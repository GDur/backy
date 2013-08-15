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

  calcLastErrors(List<num> expected){
    for(num i = 0; i < errors.length; i++) {
      errors[i] = neuron.derivative(outputs[i]) * (expected[i] - outputs[i]);
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