# Efficient Multi-View Graph Clustering with Local and Global Structure Preservation

An official source code for paper Efficient Multi-View Graph Clustering with Local and Global Structure Preservation (EMVGC-LG), accepted by ACM MM 2023. Any communications or issues are welcomed. Please contact wenyiwy2022@163.com.

Anchor-based multi-view graph clustering (AMVGC) has received abundant attention owing to its high efficiency and the capability to capture complementary structural information across multiple views. Intuitively, a high-quality anchor graph plays an essential role in the success of AMVGC. However, the existing AMVGC methods only consider single-structure information, i.e., local or global structure, which provides insufficient information for the learning task. To be specific, the over-scattered global structure leads to learned anchors failing to depict the cluster partition well. In contrast, the local structure with an improper similarity measure results in potentially inaccurate anchor assignment, ultimately leading to sub-optimal clustering performance. To tackle the issue, we propose a novel anchor-based multi-view graph clustering framework termed Efficient Multi-View Graph Clustering with Local and Global Structure Preservation (EMVGC-LG). Specifically, a unified framework with a theoretical guarantee is designed to capture local and global information. Besides, EMVGC-LG jointly optimizes anchor construction and graph learning to enhance the clustering quality. In addition, EMVGC-LG inherits the linear complexity of existing AMVGC methods respecting the sample number, which is time-economical and scales well with the data size. Extensive experiments demonstrate the effectiveness and efficiency of our proposed method.

# Main function
- run.m

# Datasets
- dataset/MFeat.mat

# Citations
If you find this repository helpful, please cite our paper:
```
@inproceedings{wen2023efficient,
  title={Efficient Multi-View Graph Clustering with Local and Global Structure Preservation},
  author={Wen, Yi and Liu, Suyuan and Wan, Xinhang and Wang, Siwei and Liang, Ke and Liu, Xinwang and Yang, Xihong and Zhang, Pei},
  booktitle={Proceedings of the 31st ACM International Conference on Multimedia},
  pages={3021--3030},
  year={2023}
}
```

