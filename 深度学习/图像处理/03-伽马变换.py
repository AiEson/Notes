from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider, Button, RadioButtons
import matplotlib as mlp

# mlp.use('TkAgg')


# 核心伽马变换函数
def gamma_trans(input, gamma=2., eps=0):
    return 255. * (((input + eps) / 255.) ** gamma)




def update_gamma(val):
    gamma = slider1.val

    output = gamma_trans(inp_arr, gamma, 0.2)

    ax3.clear()
    ax3.set_title('γ=%.2f Result' % gamma)
    ax3.imshow(output, cmap='gray', vmin=0, vmax=255)

    ax4.clear()
    ax4.grid(True, linestyle=':', linewidth=1)
    ax4.set_title('Out Img Gray distribution histogram')
    ax4.set_xlim(0, 255)
    ax4.set_ylim(0, 0.15)
    ax4.hist(output.flatten(), bins=50, density=True, color='r', edgecolor='k')


if __name__ == '__main__':
    inp_arr = np.asarray(Image.open('./伽马变换/washed_out.tif').convert('L'))
    img = Image.open('./伽马变换/washed_out.tif').convert('L')
    img.crop()
    img.resize()
    fig = plt.figure()
    ax1 = fig.add_subplot(221)
    ax2 = fig.add_subplot(222)
    ax3 = fig.add_subplot(223)
    ax4 = fig.add_subplot(224)

    ax1.set_title('Raw Img')
    ax1.imshow(inp_arr, cmap='gray', vmin=0, vmax=255)

    # ax2 显示原图的灰度分布直方图
    ax2.grid(True, linestyle=':', linewidth=1)
    ax2.set_title('Raw Img Gray distribution histogram')
    ax2.set_xlim(0, 255)
    ax2.set_ylim(0, 0.15)
    ax2.hist(inp_arr.flatten(), bins=50,
             density=True, color='r', edgecolor='k')

    plt.subplots_adjust(bottom=0.3)
    s1 = plt.axes([0.25, 0.1, 0.55, 0.03], facecolor='lightgoldenrodyellow')
    slider1 = Slider(s1, 'γ: ', 0.1, 4., valfmt='%.f',
                     valinit=1., valstep=0.1)
    slider1.on_changed(update_gamma)
    slider1.reset()
    slider1.set_val(1.)
    plt.show()
