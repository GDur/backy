part of backy;

class TrainingSet {
  List<num> input;
  List<num> expected;
  TrainingSet(this.input, this.expected);
  toString(){
    return this.input.toString() + " - " +this.expected.toString();
  }
}

bool aboutTheSame(num a, num b, num precision){
  if(b >= a - precision && a + precision >= b)
    return true;
  return false;
}
bool isAboutTheSame(List<num> a,List<num> b, num precision) {
  assert(a.length == b.length);
  for(num i = 0; i < a.length; i++){
    if(!aboutTheSame(a[i], b[i], precision)){
      return false;
    }
  }
  return true;
}
class Trainer {
  Backy backy;
  var trainingSets = new List<TrainingSet>();

  num precision = 0.1;
  num maximumReapeatingCycle;
  bool printResults = false;

  Trainer({this.backy, this.maximumReapeatingCycle,  this.precision, this.printResults }){
    assert(!isAboutTheSame([-0.9999999999620734,
                            -0.995292083303926,
                            -0.6318716862974137,
                            0.9797717789632072],
                            [-1, -1, -1, 1], .3));
    assert(isAboutTheSame([-0.9999999999620734,
                            -0.995292083303926,
                            -0.9318716862974137,
                            0.9797717789632072],
                            [-1, -1, -1, 1], .3));
    }

  addTrainingCase(List<num> input, List<num> expected) {
    assert(input.length == backy.inputLength);
    assert(expected.length == backy.outputLength);

    // to make sure that it's not the reference of the list which is inserted
    List<num> tmp = new List<num>();
    for(num i = 0; i < input.length; i++){
      tmp.add(input[i]);
    }
    List<num> tmp2 = new List<num>();
    for(num i = 0; i < expected.length; i++){
      tmp2.add(expected[i]);
    }
    var tc = new TrainingSet(tmp, tmp2);

    trainingSets.add(tc);
  }

  num trainOnlineSets() {
    assert(precision < 1);
    assert(maximumReapeatingCycle > 1);

    for(num mrc = 0; mrc < maximumReapeatingCycle; mrc++){
      for(num i = 0; i < trainingSets.length; i++){
        backy.trainOnline(trainingSets[i].input, trainingSets[i].expected);
      }
      var isSuccessful = true;
      for(num i = 0; i < trainingSets.length; i++){
        var outputs = backy.use(trainingSets[i].input);
        if(!isAboutTheSame(trainingSets[i].expected, outputs, precision)){
          isSuccessful = false;
        }
      }
      if(isSuccessful){
        return mrc + 1;
      }
    }
    return -1;
  }

  SetTrainingSets(List<List<List<num>>> newTS){
    for(List<List<num>> set in newTS) {
      assert(set.length == 2);
      trainingSets = new List<TrainingSet>();
      trainingSets.add(new TrainingSet(set[0], set[1]));
    }
  }
/*
  num trainNewOnlineSets(int maximumReapeatingCycle, num precision, List<List<List<num>>> trainingSets) {
    assert(precision < 1);
    assert(maximumReapeatingCycle > 1);

    this.precision = precision;
    this.trainingSets = trainingSets;
    this.maximumReapeatingCycle = maximumReapeatingCycle;

    bool SuccessfullyTrained = true;
    for(num i = 0; i < maximumReapeatingCycle; i++){
      SuccessfullyTrained = true;
      for(List<List<num>> set in trainingSets) {
        assert(set.length == 2);
        backy.trainOnline(set[0], set[1]);

        List<num> results = backy.use(set[0]);
        print(results);
        for(num r = 0; r < results.length; r++)
          if(!aboutTheSame(results[r], set[1][r], precision))
            SuccessfullyTrained = false;
      }
      if(SuccessfullyTrained) {
        if(printResults)
          print("Successfully Trained! Accuracity: $precision, Trainingsteps: $i\n");
        return i;
      }
    }
    if(!SuccessfullyTrained && printResults){
      //print("Unsuccessfull Training! Accuracity: $precision, Trainingsteps: $maximumReapeatingCycle\n" + this.toString());
      print("Unsuccessfull Training! Accuracity: $precision, Trainingsteps: $maximumReapeatingCycle\n");
    }
    return -1;
  }
*/


  String toString(){
    return "trainer.trainNewOnlineSets($maximumReapeatingCycle, $precision, [" + trainingSets.join(",\n").toString() + "]);";
  }
}

