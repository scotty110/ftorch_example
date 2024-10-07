"""Module defining a simple PyTorch 'Net' for coupling to Fortran."""

import torch
from torch import nn


class SimpleNet(nn.Module):
    """PyTorch module multiplying an input vector by 2."""

    def __init__(self,) -> None:
        """
        Initialize the SimpleNet model.
        """
        super().__init__()

    def forward(self, in_x: torch.Tensor, landmass: torch.Tensor) -> torch.Tensor:
        ''' 
        Don't do anything with landmass for now
        '''
        return in_x * 2


if __name__ == "__main__":
    model = SimpleNet()
    model = model.to(device="cuda", dtype=torch.float64)

    model.eval()

    # Save the model
    script_model = torch.jit.script(model)
    script_model.save("/weights/simple_net.pt")