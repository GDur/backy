using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;
using System.Text;

public class NNBackpropagation
{
	List<List<double>> layers;
	List<List<double>> nets;
	List<List<double>> errors;
	List<List<List<double>>> weights;
	double initialWeightValue = 0.5;
	double bias = 0.5;
	bool   useBias = false;
	double learingFactor = 200;
	
	double activation (double x)
	{
		x = 1 / (1 + Math.Pow (Math.E, (-1 * x)));
		return biasFunction (x);
	}

	double derivative (double x)
	{
		x = activation (x);
		x = x * (1 - x);
		return x;
	}
	
	public NNBackpropagation (int[] layerDimensions)
	{
		weights = new List<List<List<double>>> ();
		genLayers (layerDimensions);
		genWeights (layerDimensions);		
		
		
		Debug.Log ("Using bias: " + useBias);
		Debug.Log ("initialWeightValue: " + initialWeightValue);
		Debug.Log ("bias: " + bias);
		
		
		Debug.Log ("nets: " + showList (nets));	
		Debug.Log ("layers: " + showList (layers));	
		Debug.Log ("errors: " + showList (errors));	
		Debug.Log ("weights: " + showList (weights));	
	}
	
	double biasFunction (double x)
	{	 
		if (!useBias)
			return x;
		
		if (x > bias)
			return 1.0;				
		return 0.0;
	}
	
	void assert (bool bla, String msg)
	{
		if (!bla) {
			Debug.LogError ("Assertion Failed: " + msg);
		}
	}
	
	double networth (int layersAndWeightsIndex, int weightsRow)
	{
		//assert(input.Count == weigthsRow.Count);
	    
		double net = 0.0;
		for (int i = 0; i < layers[layersAndWeightsIndex].Count; i++) {
			net += layers [layersAndWeightsIndex] [i] * weights [layersAndWeightsIndex] [weightsRow] [i];
		}
		return net;
	}
	
	double errorworth (int layersAndWeightsIndex, int weightsColumn)
	{
		//assert(input.Count == weigthsRow.Count);
	    
		double net = 0.0;
		for (int i = 0; i < layers[layersAndWeightsIndex].Count; i++) {
			net += errors [layersAndWeightsIndex] [i] * weights [layersAndWeightsIndex - 1] [i] [weightsColumn];
		}
		return net;
	}
	
	int lastIndex ()
	{
		return layers.Count - 1;
	}
	
	public List<double> use (double[] inputs)
	{		
		layers [0] = new List<double> (inputs); // trick for generalliseziza0riati0rn
		
		for (int i = 1; i < layers.Count; i++) {
			for (int j = 0; j < layers[i].Count; j++) {
				double tmpNet = networth (i - 1, j);
				layers [i] [j] = activation (tmpNet);
			}
		}
		//Debug.Log("used" + layers[lastIndex()][0] +" - "+ layers[lastIndex()][1]);
		return layers [lastIndex ()];
	}
	
	public void train (double[] inputs, double[] expected)
	{
		assert (inputs.Length == layers [0].Count, "Train() inputlenght != layers[0]count");
		assert (expected.Length == layers [lastIndex ()].Count, "Train() expected.Length != layers[lastIndex()].Count");
		
		Debug.Log ("Train...");
		
		// calculate outputvalues
		
		layers [0] = new List<double> (inputs); // trick for generalliseziza0riati0rn
		
		for (int i = 1; i < layers.Count; i++) {
			for (int j = 0; j < layers[i].Count; j++) {
				double tmpNet = networth (i - 1, j);
				nets [i] [j] = tmpNet;
				layers [i] [j] = activation (tmpNet);
			}
		}
		Debug.Log ("nets: " + showList (nets));	
		Debug.Log ("layers: " + showList (layers));	
		// calculate errorsvalues (backwards)
		
		// trick for generalliseziza0riati0rn
		for (int j = 0; j < layers[lastIndex()].Count; j++) {
			errors [lastIndex ()] [j] = expected [j] - layers [lastIndex ()] [j];
		}
		
		// set deltavalues
		for (int i = lastIndex(); i > 1; i--) {
			for (int j = 0; j < layers[i - 1].Count; j++) {
				errors [i - 1] [j] = errorworth (i, j);
			}
		}
		Debug.Log ("errors: " + showList (errors));	
		// REMEMBER THE FIRST LAYER CONTAINS INPUT VALUES
		
		// errors[0] = new List<double>(layers[0]);
		
		
		Debug.Log ("weights: " + showList (weights));	
		// über weights
		for (int w = 0; w < weights.Count; w++) {
			// neuronlayer n
			for (int n = 0; n < layers[w].Count; n++) {
				// neuronlayer n + 1
				double tmpInput = layers [w] [n];
				
				for (int n_p_1 = 0; n_p_1 < layers[w + 1].Count; n_p_1++) {
					//Debug.Log (w + " " + n + " " + n_p_1);
					
					weights [w] [n_p_1] [n] = weights [w] [n_p_1] [n] + learingFactor * errors [w + 1] [n_p_1] * derivative (nets [w + 1] [n_p_1]) * tmpInput;
				}
			}
		}
		Debug.Log ("weights: \n" + showList (weights));		
	}

	void genWeights (int[] layerDimensions)
	{
		
		for (int numberOfLayers = 1; numberOfLayers < layerDimensions.Length; numberOfLayers++) {
			
			
			List<List<double>> height = new List<List<double>> ();			
			for (int numberOfNeurons = 0; numberOfNeurons < layerDimensions[numberOfLayers]; numberOfNeurons++) {
				
				
				List<double> width = new List<double> ();			
				for (int numberOfInputs = 0; numberOfInputs < layerDimensions[numberOfLayers - 1]; numberOfInputs++) {
					
					width.Add (initialWeightValue);
				}		
				
				height.Add (width);
			}			
			
			weights.Add (height);
		}
		// Debug.Log("weights: " + showList(weights));
	}
	
	void genLayers (int[] layerDimensions)
	{
		layers = new List<List<double>> ();
		for (int i = 0; i < layerDimensions.Length; i++) {
			List<double> tmp = new List<double> ();			
			for (int j = 0; j < layerDimensions[i]; j++) {
				tmp.Add (0);
			}			
			layers.Add (tmp);
		}
		
		nets = new List<List<double>> ();
		for (int i = 0; i < layerDimensions.Length; i++) {
			List<double> tmp = new List<double> ();			
			for (int j = 0; j < layerDimensions[i]; j++) {
				tmp.Add (0);
			}			
			nets.Add (tmp);
		}
		
		errors = new List<List<double>> ();
		for (int i = 0; i < layerDimensions.Length; i++) {
			List<double> tmp = new List<double> ();			
			for (int j = 0; j < layerDimensions[i]; j++) {
				tmp.Add (0);
			}			
			errors.Add (tmp);
		}
	}
	
	string showList (List<double> tmp)
	{		
		StringBuilder builder = new StringBuilder ();
		foreach (double safePrime in tmp) {
			// Append each int to the StringBuilder overload.
			builder.Append (safePrime).Append (", ");
		}
		string result = builder.ToString ();
		result = "\n\t\t[" + result.Substring (0, result.Length - 2) + "]";
		//Debug.Log(result);
		return result;
	}

	string showList (List<List<double>> tmp)
	{
		StringBuilder builder = new StringBuilder ();
		foreach (List<double> safePrime in tmp) {
			// Append each int to the StringBuilder overload.
			builder.Append (showList (safePrime)).Append (", ");
		}
		string result = builder.ToString ();
		result = "\t[" + result.Substring (0, result.Length - 2) + "\n\t]";
		return result;
	}

	string showList (List<List<List<double>>> tmp)
	{
		StringBuilder builder = new StringBuilder ();
		foreach (List<List<double>> safePrime in tmp) {
			// Append each int to the StringBuilder overload.
			builder.Append (showList (safePrime)).Append (", \n");
		}
		string result = builder.ToString ();
		result = "[\n" + result.Substring (0, result.Length - 3) + "\n]";
		//  Debug.Log (result);
		return result;
	}
}
