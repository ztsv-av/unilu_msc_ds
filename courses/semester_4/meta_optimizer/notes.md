what if we do the following:
step 6.4: we update the parameters at specific weight_param_name and bias_param_name
step 6.5: we compute the loss with the specific meta_nn and sum it up to meta_nns_loss variable
step 6.6: we revert main_model parameters to the original state.
then we use single meta_optimizer that has all the parameters of meta_nn networks and meta_nns_loss to backpropagate all the meta_nn networks. is that possible? so, my logic is as follows:
step 1: store original weights
step 2: main model forward pass and loss
step 3: reset main_optimizers
step 4: compute gradients for main_model
step 5: compute main_optimizers updates (input to the meta_layer_nns)
step 6.2: pass optimizers parameter updates of layer i to meta_layer_nns[i]
step 6.4: update main_model weights at layer i (weight_param_name and bias_param_name) with output of step 6.2
step 6.5: forward pass of main model to compute new outputs with updated weights by meta_layer_nn and compute loss. sum this loss with total_meta_layer_nns_loss
step 6.6: restore original weights of the main_model
step 7: backpropogate total_meta_layer_nns_loss with meta_optimizer updateing ONLY meta_layer_nns weigths (does this also update main_model weights or not? shouldn't because meta_optimizer does not store weights of main_model, right?)
step 8: update main_model weights with meta_outputs
step 9: check that main_model parameters changed
step 10: check that gradients flow to meta_layer_nns
step 11: 
running_loss += loss.item() # from step 2! 
 _, predicted = outputs.max(1) # from step 2!
total += labels.size(0)
correct += predicted.eq(labels).sum().item
