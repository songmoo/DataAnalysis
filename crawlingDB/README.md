# Image 
# [CNN](https://colab.research.google.com/github/songmoo/DataAnalysis/blob/master/image/image3.ipynb)
# [CNN2](https://colab.research.google.com/github/songmoo/DataAnalysis/blob/master/image/CNN.ipynb)
# [CNN 설명](http://taewan.kim/post/cnn/)
CNN(Convolutional Neural Network)은 이미지의 공간 정보를 유지하면서 인접 이미지와의 특징을 효과적으로 인식하고 강조하는 방식으로 이미지의 특징을 추출하는 부분과 이미지를 분류하는 부분으로 구성됩니다. 특징 추출 영역은 Filter를 사용하여 공유 파라미터 수를 최소화하면서 이미지의 특징을 찾는 Convolution 레이어와 특징을 강화하고 모으는 Pooling 레이어로 구성됩니다.

CNN은 Filter의 크기, Stride, Padding과 Pooling 크기로 출력 데이터 크기를 조절하고, 필터의 개수로 출력 데이터의 채널을 결정합니다.

CNN는 같은 레이어 크기의 Fully Connected Neural Network와 비교해 볼 때, 학습 파라미터양은 10% 규모입니다. 은닉층이 깊어질 수록 학습 파라미터의 차이는 더 벌어집니다. CNN은 Fully Connected Neural Network와 비교하여 더 작은 학습 파라미터로 너 높은 인식률을 제공합니다.


# [object_detection](https://colab.research.google.com/github/songmoo/DataAnalysis/blob/master/image/image2.ipynb)
### [참고](http://saneblog.tistory.com/9)
### [참고2](http://crystalcube.co.kr/192)
### [참고3](https://kangbk0120.github.io/articles/2017-07/first-gan)

