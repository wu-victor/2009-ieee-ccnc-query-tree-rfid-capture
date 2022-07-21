# 2009 IEEE CCNC Conference Paper

Using Generalized Query Tree to Cope with the Capture Effect in RFID Singulation

https://ieeexplore.ieee.org/document/4784899

## Abstract

The Query Tree Protocol (QT) in Law et al. (2000) is an efficient RFID tag singulation algorithm that is guaranteed to read all the tags in the broadcast range of a reader. However, QT ignores the capture effect. That is, after the reader broadcasts a bit string query prefix, it is assumed that it can distinguish one of three responses, namely {no response, one response, collision}. If the capture effect is modeled, QT would no longer be guaranteed to singulate all the tags in the reader's range, since "capturing" a tag ID in the midst of a collision would leave all the other tags in that collision unsingulated. In this paper, we introduce two modifications to QT that always singulate all the tags even when the capture effect is considered. We call these the Generalized Query Tree Protocols (GQT1, GQT2). We provide analytical bounds and simulation results of the singulation times of these new protocols in relation to QT.