function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
% NNCOSTFUNCTION 分類を行う2層のニューラル・ネットワーク用の
% ニューラルネット・ワーク・コスト関数を実装する
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda)は、ニューラル・ネットワークのコストと勾配を計算します。 
%   ニューラル・ネットワークのパラメーターは、ベクトルnn_paramsに
%   「アンロール」され、ウェイト行列に変換されている必要があります。
%   
%   返されるパラメーターgradは、ニューラル・ネットワークの偏微分の
%   「アンロール」されたベクトルでなければなりません。
%

% 2層ニューラル・ネットワークのウェイト行列であるパラメーターTheta1とTheta2に、
% nn_paramsを再構成する
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% いくつかの有用な変数を設定する
m = size(X, 1);
         
% 次の変数を正しく返す必要があります
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== ここにコードを実装する ======================
% 指示: 次のパートを実装することによって、コードを完成させる必要があります。
% 
%
% パート 1: ニューラルネット・ワークにフィードフォワードし、変数Jにコストを
%          セットして返します。パート1を実装したら、ex4.mで計算されたコストを
%          検証することによって、コスト関数の計算が正しいことを検証できます。
%
%
% パート 2: バックプロパゲーションのアルゴリズムを実装して、勾配Theta1_gradと
%          Theta2_gradを計算します。Theta1_gradとTheta2_gradにそれぞれ
%          Theta1とTheta2に関するコスト関数の偏微分を戻す必要があります。
%          パート2を実装したら、checkNNGradientsを実行して実装が正しいことを
%          確認できます。
%
%          注意: 関数に渡されるベクトルyは、1..Kの値を含むラベルのベクトルです。
%               ニューラル・ネットワークのコスト関数で使用するには、このベクトルを
%               1と0のバイナリー・ベクトルにマップする必要があります。
%               
%
%          ヒント: 最初は、forループを使用してバックプロパゲーションを
%                 実装することをお勧めします。
%               
%
% パート 3: コスト関数と勾配とともに正則化を実装します。
%
%          ヒント: これをバックプロパゲーションのコードとともに実装することが
%                 できます。つまり、正則化の勾配を別々に計算して、パート2の
%                 Theta1_gradとTheta2_gradに追加できます。
%               
%









YUgv0tF8otzIyP40vqVfCMN9k6W7elyAaoHsdpHphsa8bFZ56LQ9GuxM8wlDyZehNhfSSvruD2a+h3UPb+390SEpQptP0MLLUYnxs9EMnQJeC2k8c/dMDleavkKHm2E0y9AbFLxdZF4tt/bczH4WH47qGWAoTMVvfXOqnrF0gzq5j8Wne3sUMf+w6EmEYxZ7amFBV1gHTZes3hO1/PHV6tuCFgDHXJ9/VGdg0lR2CqhN3fSnUrAiLlkxLYJTxffG7sTsm5US/YW2vx1UeQp1IYpXGaV628y2StFtvejtU+IdUILtaLOzG92uB+qeO+VL7xf3iAHi7LmBXvp5AIbFd/cPg6/FAPk2QoFaHwhS/R0L6CdIIk09vb8Emk9rY0Pw45mq/PrRaOolHt+RjPKIuQJwCsGcIga/GYuEAHOzbIcij7mc1DVplrBP06w//X0DJIZQzlo/LXIPBjMbqAwCH6hMj2oo0H1eCGYoEiOPReeC4Y+H+nG4lC6cdu4Npuwj1yLku3+q7u3vdqlIslq/t70q59G/FS0vEYq3IFDKAMu+PRbMXD5UoxzfISJCO6TuHR/TqRFHCRJkqni/gn+BNtsBAPh7MqNzAHz642yREcmTVVNg0najDA6sSPuxEYl2pCoW91RlDEo+W9nrOqty0FhndPPwusuy46fe/Bl0G8PFEoArlKKrNJdQxGfIzalYqdVJLSirLva1BZsdUHDbw0Btauw25wI/rwR5yikklm/ayaGEpVjS6w0VeDqWAKlR5gWN5PhVwI/mVJEdLrp+2VWVV22yQIqhF8ETa4xviGA/nyTl5qlWofO8BRqL+Mog9f5Qj55O3cL09NudUJAJwlQ=








% -------------------------------------------------------------

% =========================================================================

% 勾配をアンロールする
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
