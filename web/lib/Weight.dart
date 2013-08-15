part of backy;

class Weight {
  List<List<num>> weights = new List<List<num>>();
  num width, height;
  Neuron neuron;

  Weight(this.width, this.height, this.neuron, num i) {

    for(num i = 0; i < height; i++) {
      var tmp = new List<num>();
      for(num j = 0; j < width; j++) {
        tmp.add(neuron.initialWeights());
      }
      weights.add(tmp);
    }
    if(neuron.useXOR){
      if(i == 0)
        weights = [[-1.1431, -3.80070], [3.791287, 1.391485]];
      if(i == 1)
        weights = [[-2.665579, -3.874355]];
    }
  }

  adjustWeights(List<num> errors,  List<num> outputs, List<num> outputsNext){
    for(num h = 0; h < height; h++) {
      for(num w = 0; w < width; w++) {

        num p = neuron.derivative(outputs[h]);
        num result = neuron.learningRate * errors[h] * p * outputsNext[w];

        weights[h][w] = weights[h][w] + result;
      }
    }
  }

  List<num> multiply(List<num> inputs, bool useT) {
    // input.lenghth muss entweder gleich der höhe oder weite sein
    assert(width == inputs.length || height == inputs.length);

    List<num> results;
    if(!useT){
      // die output länge ist immer die diemnsion die nciht gleich des inpuzt layers ist
      results = new List<num>(height);

      for(num h = 0; h < height; h++){
        num value = .0;

        for(num w = 0; w < width; w++){
          value += inputs[w] * weights[h][w];
        }
        results[h] = value;
      }
    }else{
      results = new List<num>(width);
      for(num w = 0; w < width; w++){
        num value = .0;

        for(num h = 0; h < height; h++){
          value += inputs[h] * weights[h][w];
        }
        results[w] = value;
      }

    }
    return results;
  }

  List<num> mackpropagateError(List<num> errors, List<num> outputs) {
    // input.lenghth muss entweder gleich der höhe oder weite sein
    assert(width == errors.length || height == errors.length);

    // die output länge ist immer die diemnsion die nciht gleich des inpuzt layers ist
    List<num> results = new List<num>(width);

    for(num w = 0; w < width; w++){
      num error = .0;

      for(num h = 0; h < height; h++){
        error += errors[h] * weights[h][w];
      }
      results[w] = neuron.derivative(outputs[w]) * error;
    }

    return results;
  }

  String toString() {
    String tmp = "";
    for(num j = 0; j < height; j++){
      tmp += "\t" + weights[j].toString() + "\n";
    }
    return tmp;
  }
}