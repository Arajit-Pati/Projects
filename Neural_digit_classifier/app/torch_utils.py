import torch
import torch.nn as nn
import torchvision.transforms as transforms
import numpy as np
from PIL import Image
import io

# load model
class NeuralNet(nn.Module):
    def __init__(self, input_size, hidden_size, num_classes):
        super(NeuralNet, self).__init__()
        self.input_size = input_size
        self.l1 = nn.Linear(input_size, hidden_size) 
        self.relu = nn.ReLU()
        self.l2 = nn.Linear(hidden_size, num_classes)  
    
    def forward(self, x):
        out = self.l1(x)
        out = self.relu(out)
        out = self.l2(out)
        # no activation and no softmax at the end
        return out

input_size = 784 # 28x28
hidden_size = 500 
num_classes = 10

model = NeuralNet(input_size, hidden_size, num_classes)

PATH = 'mnist-ffn.pth'
model.load_state_dict(torch.load(PATH))
model.eval()

# image -> tensor
def transform_image(image_bytes):
    transform = transforms.Compose([ transforms.Grayscale(num_output_channels = 1),
                                    transforms.Resize((28,28)),
                                    transforms.ToTensor(), 
                                    transforms.Normalize((0.1307, ), (0.3081,)) ])

    image = Image.open(io.BytesIO(image_bytes))
    return transform(image).unsqueeze(0)

# predict
def get_prediction(image_tensor):
    image_tensor = image_tensor.reshape(-1, 28*28)
    outputs = model(image_tensor)
    # max returns (value ,index)
    _, predicted = torch.max(outputs.data, 1)
    return predicted


