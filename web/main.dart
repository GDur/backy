part of backy;

void main() {

  var neuron = new Neuron();

  var fran = new Backy([2, 2, 1], neuron);
  if(neuron.useTanh){

    for(num i = 0; i < 1000; i++){
      fran.train([-1,-1], [-1]);
      fran.train([-1, 1], [ 1]);
      fran.train([ 1,-1], [ 1]);
      fran.train([ 1, 1], [-1]);
    }

    print(fran);
    print(fran.use([-1,-1]));
    print(fran.use([-1, 1]));
    print(fran.use([ 1,-1]));
    print(fran.use([ 1, 1]));
  } else {
    for(num i = 0; i < 10000; i++){
      fran.train([ 0, 0], [ 0]);
      fran.train([ 0, 1], [ 1]);
      fran.train([ 1, 0], [ 1]);
      fran.train([ 1, 1], [ 0]);
    }
    print(fran);
    print(fran.use([ 0, 0]));
    print(fran.use([ 0, 1]));
    print(fran.use([ 1, 0]));
    print(fran.use([ 1, 1]));
  }
}