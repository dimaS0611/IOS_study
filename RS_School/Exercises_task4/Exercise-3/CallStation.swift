import Foundation

final class CallStation {
    
    var usersArr = Set<User>()
    var callsArr = Set<Call>()
}

extension CallStation: Station {
    
    func users() -> [User] {
        return Array(self.usersArr)
    }
    
    func add(user: User) {
        self.usersArr.insert(user)
    }
    
    func remove(user: User) {
        self.usersArr.remove(user)
    }
    
    func execute(action: CallAction) -> CallID? {
        
        switch action {
        
        case .start(let from, let to):
            
            if !usersArr.contains(from) && !usersArr.contains(to) {
                return nil
            }
            
            if !usersArr.contains(from) || !usersArr.contains(to) {
                let call = Call(id: UUID(), incomingUser: from, outgoingUser: to, status: .ended(reason: .error))
                callsArr.insert(call)
                return call.id
            }
            
            let filterFrom = Array(callsArr.filter { $0.incomingUser == to })
            let filterTo = Array(callsArr.filter { $0.outgoingUser == to })
            
            if !filterTo.isEmpty || !filterFrom.isEmpty {
                let call = Call(id: UUID(), incomingUser: from, outgoingUser: to, status: .ended(reason: .userBusy))
                callsArr.insert(call)
                return call.id
            }
            
            let call = Call(id: UUID(), incomingUser: from, outgoingUser: to, status: .calling)
            callsArr.insert(call)
            return call.id
            
        case .answer(let from):
           
            let call : Call = currentCall(user: from)!
            
            if !usersArr.contains(from) {
                callsArr.remove(call)
                callsArr.update(with: Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .ended(reason: .error)))
                
                return nil
            } else {
                callsArr.remove(call)
                callsArr.update(with: Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .talk))
                
                return call.id
            }
            
        case .end(let from):
            
            let call : Call = currentCall(user: from)!
            callsArr.remove(call)
            
            if call.status == .talk {
                callsArr.update(with: Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .ended(reason: .end)))
            }
            else if call.status == .calling {
                callsArr.update(with: Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .ended(reason: .cancel)))
            }
            else {
                callsArr.update(with: Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: .ended(reason: .end)))
            }
            return call.id
            
        default:
            return nil
        }
    }
    
    func calls() -> [Call] {
        
        return Array(self.callsArr)
    }
    
    func calls(user: User) -> [Call] {
        
        let incoming = Array( callsArr.filter { $0.incomingUser.id == user.id } )
        let outgoing = Array( callsArr.filter { $0.outgoingUser.id == user.id } )
        
        return incoming + outgoing
    }
    
    func call(id: CallID) -> Call? {
        
        let call = callsArr.filter { $0.id == id }
        return call.first
    }
    
    func currentCall(user: User) -> Call? {
        
        var call : Call
        
        let incomingCall = Array( callsArr.filter { $0.incomingUser == user } )
        let outgoingCall = Array( callsArr.filter { $0.outgoingUser == user } )
        
        if incomingCall.count == 0 && outgoingCall.count == 0 {
            return nil
        }
        
        if incomingCall.count == 0 {
            if outgoingCall[outgoingCall.count - 1].status == .talk || outgoingCall[outgoingCall.count - 1].status == .calling {
                call = outgoingCall[0]
                return call
            }
        }
        else {
            if incomingCall[incomingCall.count - 1].status == .talk || incomingCall[incomingCall.count - 1].status == .calling {
                call = incomingCall[0]
                return call
            }
        }
        
        return nil
        
    }
}
