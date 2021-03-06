#' @export
makeRLearner.regr.bdk = function() {
  makeRLearnerRegr(
    cl = "regr.bdk",
    package = "kohonen",
    par.set = makeParamSet(
      makeIntegerLearnerParam(id = "xdim", default = 8L, lower = 1L),
      makeIntegerLearnerParam(id = "ydim", default = 6L, lower = 1L),
      makeDiscreteLearnerParam(id = "topo", default = "rectangular", values = c("rectangular", "hexagonal")),
      makeIntegerLearnerParam(id = "rlen", default = 100L, lower = 1L),
      makeNumericVectorLearnerParam(id = "alpha", default = c(0.05, 0.01), len = 2L),
      makeNumericVectorLearnerParam(id = "radius"),
      makeNumericLearnerParam(id = "xweight", default = 0.75, lower = 0),
      makeLogicalLearnerParam(id = "contin"),
      makeLogicalLearnerParam(id = "toroidal", default = FALSE),
      makeDiscreteLearnerParam(id = "n.hood", values = c("circular", "square"))
    ),
    properties = c("numerics"),
    name = "Bi-Directional Kohonen map",
    short.name = "bdk",
    note = ""
  )
}

#' @export
trainLearner.regr.bdk = function(.learner, .task, .subset, .weights = NULL, xdim, ydim, topo, ...) {
  d = getTaskData(.task, .subset, target.extra = TRUE)
  grid = learnerArgsToControl(class::somgrid, xdim, ydim, topo)
  kohonen::bdk(as.matrix(d$data), Y = d$target, grid = grid, keep.data = FALSE, ...)
}

#' @export
predictLearner.regr.bdk = function(.learner, .model, .newdata, ...) {
  kohonen::predict.kohonen(.model$learner.model, as.matrix(.newdata), ...)$prediction[, 1L]
}
