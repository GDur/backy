part of backy;

class Trainer{
  var trainingSets = new List<List<List<num>>>();
  Backy backy;
  num precision = 0; // maybe unsolvable
  num maximumReapeatingCycle = 200;
  bool printResults = false;

  Trainer(this.backy, [this.printResults = false]){
    assert(aboutTheSame(2, 1.9, .1));
    assert(aboutTheSame(2, 2.1, .1));

    assert(!aboutTheSame(2, 1.8, .1));
    assert(!aboutTheSame(2, 2.2, .1));
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

    trainingSets.add([tmp, tmp2]);
  }

  num trainOnlineSets(int maximumReapeatingCycle, num precision) {
    return trainNewOnlineSets(maximumReapeatingCycle, precision, this.trainingSets);
  }

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

  bool aboutTheSame(num a, num b, num precision){
    if(b >= a - precision && a + precision >= b)
      return true;
    return false;
  }

  String toString(){
    return "trainer.trainNewOnlineSets($maximumReapeatingCycle, $precision, [" + trainingSets.join(",\n").toString() + "]);";
  }
}
