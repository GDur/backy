library backy;

import 'dart:math' as Math;
//import 'package:serialization/serialization.dart';

part 'layer.dart';
part 'weight.dart';
part 'neuron.dart';

part 'trainer.dart';

class Backy {
  bool useP;
  List<Layer> layers  = new List<Layer>();
  List<Weight> weights  = new List<Weight>();

  Neuron neuron;
  num inputLength, outputLength;

  List<num> netDimensions;

  Backy(this.netDimensions, this.neuron, [this.useP = false]) {
    inputLength = netDimensions[0];
    outputLength = netDimensions[netDimensions.length - 1];
    createLayers();
    createWeights();
  }


  setWeights(List weights) {
    this.weights = weights;
  }

  getWeights(){
    return this.weights.toList(growable: false);
  }

  trainOnline(List<num> input, List<num> expected) {
    assert(input.length == inputLength);
    assert(expected.length == outputLength);

    // calculate net and outputvalues
    layers[0].outputs = input;

    for(num i = 1; i < layers.length; i++) {
      layers[i].nets = weights[i - 1].multiply(layers[i - 1].outputs, false);
      layers[i].setOutputs();
    }

    // calculate errors
    layers.last.calcLastErrors(expected);

    for(num i = layers.length - 1; i > 1; i--) {
      layers[i - 1].calcErrors(weights[i - 1], layers[i].errors);
    }

    // backpropagate
    for(num i = 0; i < weights.length; i++) {
      weights[i].adjustWeights(layers[i + 1].errors, layers[i + 1].outputs, layers[i].outputs);
    }
  }

  use(List<num> input) {
    assert(input.length == inputLength);

    // calculate net and outputvalues
    layers[0].outputs = input;
    for(num i = 1; i < layers.length; i++) {
      layers[i].nets = weights[i - 1].multiply(layers[i - 1].outputs, false);
      layers[i].setOutputs();
    }

    return layers.last.outputs;
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
      weights.add(new Weight(netDimensions[i], netDimensions[i + 1], neuron, i, this));
    }
  }
}