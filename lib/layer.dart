part of backy;

class Layer {
  List<num> nets = new List<num>();
  List<num> outputs = new List<num>();
  List<num> errors = new List<num>();


  Neuron neuron;
  Layer(num neuronCount, this.neuron) {
    for(num i = 0; i < neuronCount; i++){
      nets.add(.0);
      errors.add(.0);
      outputs.add(.0);
    }
  }

  num finalStep(num index, num error) => neuron.derivative(outputs[index]) * (error);

  calcLastErrors(List<num> expected){
    for(num i = 0; i < errors.length; i++) {
      errors[i] = finalStep( i, (expected[i] - outputs[i]));
    }
  }

  calcErrors(Weight weight, List<num> previousErrors) {
    // input.lenghth muss entweder gleich der höhe oder weite sein
    assert(weight.width == previousErrors.length || weight.height == previousErrors.length);

    // die output länge ist immer die diemnsion die nciht gleich des inpuzt layers ist

    for(num w = 0; w < weight.width; w++){
      num error = .0;

      for(num h = 0; h < weight.height; h++){
        error += previousErrors[h] * weight.weights[h][w];
      }
      errors[w] = finalStep( w, error);
    }
  }


  setOutputs(){
    for(num i = 0; i < nets.length; i++) {
      outputs[i] = neuron.activation(nets[i]);
    }
  }

  String toString(){
    return "\tnets: " + nets.toString() + "\n\toutputs: " + outputs.toString() + "\n\terrors: " + errors.toString() + "\n";
  }
}