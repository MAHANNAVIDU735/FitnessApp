class FirestoreScheduleExercise: Codable
{
    var excerciseId:String
    var reps: Int
    var sets: Int
    var weight: Int?
    var totalTime: Int // in  seconds
    var startedAt: String
    var elapsedTime: Int  // milli seconds
}
