import 'dart:math';

import 'package:villers_boys_ii/user.dart';

class DriveAssessment{
  /// Stores the data of pre-drive assessment and calculates the overall fatigue levels
  DriveAssessment(this.questionnaireScore, this.reactionTime, this.memoryScore, this.user);

  int questionnaireScore;
  double reactionTime;
  double memoryScore;
  User user;

  int reactionScore = 0;
  int finalMemoryScore = 0;

  static const questionnaireThresholds = [22,34,50];
  //TODO Determine better thresholds
  static const reactionThresholds = [20,30,50];
  static const memoryThresholds = [20,30,50];

  static const avgThresholds = [20,30,50];

  void calcReactionScore(){
    /// Uses the stored reaction time and baseline to determine a score out of 50
    /// If reactionTime <= baseline: 0
    /// If reactionTime >= baseline * 2: 50
    /// All other values evenly distributed within this range
    double baseline = user.getReactionBaseline();
    double diff = (reactionTime/baseline) - 1;
    diff = min(max(diff, 0), 1);
    reactionScore = (50 * diff).round();
  }

  void calcMemoryScore(){
    double baseline = user.getMemoryBaseline();
    double diff = (memoryScore/baseline);
    diff = min(max(diff, 0), 1);
    finalMemoryScore =  50 - (50 * diff).round();
  }

  void setQuestionnaireScore(int score){
    questionnaireScore = score;
  }

  int getQuestionnaireScore(){
    return questionnaireScore;
  }

  void setReactionTime(double time){
    reactionTime = time;
    calcReactionScore();
  }

  int getReactionScore(){
    return reactionScore;
  }

  void setMemoryScore(double score){
    memoryScore = score;
    calcMemoryScore();
  }

  int getMemoryScore(){
    return finalMemoryScore;
  }

  int getFatigue1(){
    /// Determines the fatigue level based on the number of tests above certain thresholds
    /// Returns: 0 - No Fatigue, 1 - Some Fatigue, 2 - High Fatigue

    // [No fatigue, Med fatigue, High fatigue]
    List<int> fatigueLevels = [0,0,0];

    for(int i = 0; i < questionnaireThresholds.length; i++){
      if(questionnaireScore <= questionnaireThresholds[i]){
        fatigueLevels[i] += 1;
        break;
      }
    }

    for(int i = 0; i < reactionThresholds.length; i++){
      if(reactionScore <= reactionThresholds[i]){
        fatigueLevels[i] += 1;
        break;
      }
    }

    for(int i = 0; i < memoryThresholds.length; i++){
      if(finalMemoryScore <= memoryThresholds[i]) {
        fatigueLevels[i] += 1;
        break;
      }
    }

    int maxValue = 0;
    fatigueLevels.forEach((f) {
      maxValue = max(maxValue,f);
    });

    if(maxValue == 1){ // Equal scores for all fatigue levels
      return 1;
    } else if (fatigueLevels[0] == maxValue){
      return 0;
    } else if (fatigueLevels[1] == maxValue){
      return 1;
    } else {
      return 2;
    }
  }

  int getFatigue2(){
    /// Determines the fatigue level based on the average score
    /// Returns: 0 - No Fatigue, 1 - Some Fatigue, 2 - High Fatigue
    double avgScore = (questionnaireScore + reactionScore + finalMemoryScore)/3;

    for(int i = 0; i < avgThresholds.length; i++){
      if(avgScore <= avgThresholds[i]){
        return i;
      }
    }
    return 0;
  }
}