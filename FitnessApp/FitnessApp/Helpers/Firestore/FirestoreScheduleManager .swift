import FirebaseFirestore

class FirestoreScheduleManager  {
    static let shared: FirestoreScheduleManager  = {
        let _shared = FirestoreScheduleManager ()
        return _shared
    }()
    
    func createNewScheduleOnFirestoreDb(firestoreSchedule:FirestoreSchedule,completionWithPayload:CompletionHandlerWithData?){
        let userId = Constants.currentLoggedInFireStoreUser?.id
        
        if let _userId = userId{
            let schedulesDocumentRef = Firestore.firestore().collection(FirestoreCollections.users.rawValue).document(_userId)
            
            guard let firestoreScheduleAsDictionary = firestoreSchedule.getDictionary() else {
                completionWithPayload?(false,"Failed to Encode New User Object ",nil)
                return
            }
            schedulesDocumentRef.setData(firestoreScheduleAsDictionary) { err in
                if let err = err {
                    completionWithPayload?(false,err.localizedDescription,nil)
                    print("Error writing document: \(err)")
                } else {
                    completionWithPayload?(true,nil,nil)
                    print("Document successfully written!")
                }
            }
        }else{
            completionWithPayload?(false,nil,nil)
        }
        
    }
    
    func updaetCustomScheduleOnFirestoreDb(firestoreSchedule:FirestoreSchedule,completionWithPayload:CompletionHandlerWithData?){
        let userId = Constants.currentLoggedInFireStoreUser?.id
        
        if let _userId = userId{
            let schedulesDocumentRef = Firestore.firestore().collection(FirestoreCollections.users.rawValue).document(_userId)
            
            guard let firestoreScheduleAsDictionary = firestoreSchedule.getDictionary() else {
                completionWithPayload?(false,"Failed to Encode New User Object ",nil)
                return
            }
            schedulesDocumentRef.setData(firestoreScheduleAsDictionary) { err in
                if let err = err {
                    completionWithPayload?(false,err.localizedDescription,nil)
                    print("Error writing document: \(err)")
                } else {
                    completionWithPayload?(true,nil,nil)
                    print("Document successfully written!")
                }
            }
        }else{
            completionWithPayload?(false,nil,nil)
        }
        
    }
    
    /**
     This is used to  fetch the Schedule data  stored on  Firestore Db     */
    func getScheduleDataStoredOnFirestoreDb(completionWithPayload:CompletionHandlerWithData?){
        let scheduleDocumentRef = Firestore.firestore().collection(FirestoreCollections.schedules.rawValue)
        scheduleDocumentRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                completionWithPayload?(false,err.localizedDescription,nil)
                print("Error getting documents: \(err)")
            } else {
                var schedulesArray = [FirestoreSchedule]()
                for document in querySnapshot!.documents {
                    let _schedulesDataDictoanary = document.data()
                    let schedulesData =  FirestoreSchedule(dictionary: _schedulesDataDictoanary)
                    if let _schedulesData = schedulesData {
                        schedulesArray.append(_schedulesData)
                    }
                }
                completionWithPayload?(true,nil,schedulesArray)
            }
        }
    }
    
}
