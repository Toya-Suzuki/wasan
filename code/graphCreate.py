import pandas as pd
import matplotlib.pyplot as plt
import os

def draw_line_graph_from_csv(file_name, x_axis, y_axes=None):
    df = pd.read_csv(file_name)
    filter = [x_axis] + y_axes

    title = ["Validation Rate", "Error Rate"]
    df[filter].plot(x=x_axis, title=title[1], grid=True, rot=10, figsize=(8, 6), logx=True)
    #df[filter].plot(x=x_axis, title=title[1], rot=10, figsize=(8, 6), subplots=True, logx=True)

    plt.show()

if __name__ == "__main__":
    l = ["res", "vgg", "dense", "alex", "squ"]
    #draw_line_graph_from_csv("/home/toya/validLOSS.csv", 'LR', l[:5])
    draw_line_graph_from_csv("/home/toya/errorLOSS.csv", 'LR', l[:3])