scalaVersion := "2.12.8"
addCompilerPlugin("org.spire-math" %% "kind-projector" % "0.9.8")
scalacOptions ++= Seq(
  "-encoding",
  "UTF-8",
  "-feature",
  "-language:existentials",
  "-language:higherKinds",
  "-language:implicitConversions",
  "-language:experimental.macros",
  "-unchecked",
  "-Ywarn-dead-code",
  "-Xfatal-warnings",
  "-Ywarn-numeric-widen",
  "-Ywarn-value-discard",
  "-Xfuture",
  "-Ypartial-unification"
)
libraryDependencies += "org.typelevel" %% "cats-core" % "1.5.0"
libraryDependencies += "org.typelevel" %% "cats-effect" % "1.1.0"
libraryDependencies += "com.github.julien-truffaut" %%  "monocle-core" % "1.5.0-cats"
