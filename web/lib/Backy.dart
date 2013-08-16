part of backy;

class Backy {
  List<Layer> layers  = new List<Layer>();
  List<Weight> weights  = new List<Weight>();

  Neuron neuron;
  num inputLength, outputLength;

  List<num> netDimensions;

  Backy(this.netDimensions, this.neuron) {
    inputLength = netDimensions[0];
    outputLength = netDimensions[netDimensions.length - 1];
    createLayers();
    createWeights();
  }

  trainOnline(List<num> input, List<num> expected) {
    assert(input.length == inputLength);
    assert(expected.length == outputLength);

    // calculate net and outputvalues
    layers[0].outputs = input;

    for(num i = 0; i < weights.length; i++) {
      layers[i + 1].nets = weights[i].multiply(layers[i].outputs, false);
      layers[i + 1].setOutputs();
    }

    // calculate errors
    layers.last.calcLastErrors(expected);

    for(num i = weights.length; i > 1; i--) {
      layers[i - 1].errors = weights[i - 1].mackpropagateError(layers[i].errors, layers[i - 1].outputs);
    }

    // backpropagate
    for(num i = 0; i < weights.length; i++) {
      weights[i].adjustWeights(layers[i + 1].errors, layers[i + 1].outputs, layers[i].outputs);
    }
  }

  String toString() {
    String tmp = "[";
    for(num i = 0; i < weights.length; i++) {
      tmp += "\n" + layers[i].toString() + "\n" + weights[i].toString() + "" ;
    }
    return tmp + "]";
  }

  createLayers() {
    for(num i = 0; i < netDimensions.length; i++){
      layers.add(new Layer(netDimensions[i], neuron));
    }
  }

  createWeights() {
    for(num i = 0; i < netDimensions.length - 1; i++){
      weights.add(new Weight(netDimensions[i], netDimensions[i + 1], neuron, i));
    }
  }

  use(List<num> input) {
    assert(input.length == inputLength);

    // calculate net and outputvalues
    layers[0].outputs = input;
    for(num i = 0; i < weights.length; i++) {
      layers[i + 1].nets = weights[i].multiply(layers[i].outputs, false);
      layers[i + 1].setOutputs() ;
    }

    return layers.last.outputs;
  }
}