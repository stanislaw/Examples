# Kingpin: when viewing clusters over the international dateline clusters pins disappear

Original issue is reported at: [No clusters or pins displayed when zoomed out #116](https://github.com/itsbonczek/kingpin/issues/116).

This demo project was created by @smahmoodpbm and contains my fix of "international dateline" issue.

What is interesting is that `-[MKMapView annotationsInMapRect:]` also has this problem (as I found using this simple implementation of tree: [KPMapViewAnnotationTree.m](https://github.com/stanislaw/Examples/blob/b2585416ed6cccffde7f8977160cda431f9c9aad/kingpin/KPMapViewAnnotationTree.m)).

