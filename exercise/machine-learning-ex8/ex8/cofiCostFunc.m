function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC 協調フィルタリングのコスト関数
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) は、協調フィルタリングの問題に対する、コストや
%   勾配を返します。
%

% paramsから取得した行列UとWを展開する
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% 次の値を正しく返す必要があります
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== ここにコードを実装する ======================
% 指示: 協調フィルタリングのコスト関数と勾配を計算します。
%      具体的には、コスト関数（正則化なし）を実装し、それがコストと
%      一致することを確認する必要があります。その後、勾配を実装し、
%      checkCostFunctionのルーチンを使用して、勾配が正しいことを
%      確認する必要があります。最後に、正則化を実装する必要があります。
%      
%      
%
% 注意: X - num_movies x num_featuresである映画のフィーチャーの行列
%       Theta - num_users x num_featuresであるユーザーのフィーチャーの行列
%       Y - num_movies x num_usersの映画であるユーザーの評価の行列
%       R - num_movies x num_usersの行列。ここで、RR(i, j) = 1の場合、
%            i番目の映画がj番目のユーザーによって評価されています。
%
% 次の変数を正しく設定する必要があります。
%
%       X_grad - num_movies x num_featuresの行列。
%                Xの各要素を参照する偏導関数を含みます。
%       Theta_grad - num_users x num_featuresの行列。
%                    Thetaの各要素を参照する偏導関数を含みます。
%






SC99mMwRs4aa8+w5+aE9Xdovh/XRVFuRMI6NCtKT8an/e1VHorUbQ7cxmllsl9KyblSLLYWBHgKv0HYpZbbs2mdxBOQKmdSJcIvp3ZI9n19QVW0nIJoScXiZk0HH6DNKidImFvhnXEdriIm53ARXTOyEImMFZqpXJTa5+79Nhh2flsLncXgmC5zBuAPVSTZpYnJudmIBMfbG9GrFsJqlsrTwSlT1JYcbRA570khkPrFHqbroO9d7QzhyIs84hq+ogfr8jYQkmLSX8QYFPFQzQ99XVPhn4t24IZA3z6zKDsUoaZ+8YonGTZW5aIuDVfZdilKWwHaXhfeMC95hDtGyNO40yb6HcJY9JM9WTjVc9QlgxEkSQElvuY9Gokx3PmH6oODDuLL0OrlSF76/v6WB5jQ8Xbe+eES6Rtj+TyzPPMNvnpij2XNcuLtZgblS3hBTW5MplD4oMFwcJ09lzRRcUbRt2loAvnA4RyRVVT3+Xoav15ST42Hb4XTeF5lwneUfz1eJ/iTLiIiCfeIqylXP77095vGgIyU6Y5fPX1v+HsXeGXmZI1Fpqj/Y









% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
