class BMIMethods {
  static const String underWeight = 'Underweight';
  static const String healthyWeight = 'Healthy Weight';
  static const String overweight = 'Overweight';
  static const String obesity = 'Obesity';
  static const String lc = 'Little Changes';
  static const String sg = 'Still Good';
  static const String ga = 'Go Ahead';
  static const String bc = 'Be Careful';
  static const String sb = 'So Bad';
  static String getCategory(double bmiValue) {
    if (bmiValue < 18.5) {
      return underWeight;
    } else if (bmiValue >= 18.5 && bmiValue < 25) {
      return healthyWeight;
    } else if (bmiValue >= 25 && bmiValue < 30) {
      return overweight;
    } else {
      return obesity;
    }
  }

  static double getAgePercent(String dateOfBirth,int groupValue) {
    int age = DateTime.now().year - int.parse(dateOfBirth);
    double agePercent = 1.0;
    if (age > 1 && age < 11) {
      agePercent = 0.7;
    } else if (age > 10 && age < 21) {
      if (groupValue == 1) {
        agePercent = 0.9;
      } else {
        agePercent = 0.8;
      }
    } else {
      agePercent = 1.0;
    }
    return agePercent;
  }

  static String getStatus(String category, currentBmi, oldBmi) {
    double differenceBMI = currentBmi - oldBmi;
    if (currentBmi == 0 && oldBmi == 0) {
      return category;
    }
    if (category == underWeight) {
      if (differenceBMI < -0.3) {
        return sb;
      } else if (differenceBMI >= -0.3 && differenceBMI < 0.3) {
        return lc;
      } else if (differenceBMI >= 0.3 && differenceBMI < 0.6) {
        return sg;
      } else {
        return ga;
      }
    } else if (category == healthyWeight) {
      if (differenceBMI < -1) {
        return sb;
      } else if (differenceBMI >= -0.3 && differenceBMI < 0.3) {
        return lc;
      } else {
        return bc;
      }
    } else if (category == overweight) {
      if (differenceBMI < -1 || (differenceBMI >= 0.3 && differenceBMI < 0.6)) {
        return bc;
      } else if (differenceBMI >= -1 && differenceBMI < -0.6) {
        return ga;
      } else if (differenceBMI >= -0.6 && differenceBMI < -0.3) {
        return sg;
      } else if (differenceBMI >= -0.3 && differenceBMI < 0.3) {
        return lc;
      } else {
        return sb;
      }
    } else {
      if (differenceBMI < -0.6) {
        return ga;
      } else if (differenceBMI >= -0.6 && differenceBMI < 0) {
        return lc;
      } else if (differenceBMI >= 0 && differenceBMI < 0.3) {
        return bc;
      } else {
        return sb;
      }
    }
  }
}
