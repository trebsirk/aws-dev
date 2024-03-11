import Dependencies._

ThisBuild / scalaVersion     := "3.4.0"
ThisBuild / version          := "0.1.0-SNAPSHOT"
ThisBuild / organization     := "com.example"
ThisBuild / organizationName := "example"

lazy val root = (project in file("."))
  .settings(
    name := "ec2-demo",
    libraryDependencies += munit % Test,
    libraryDependencies += "dev.zio" %% "zio-http" % "3.0.0-RC4"
  )

// See https://www.scala-sbt.org/1.x/docs/Using-Sonatype.html for instructions on how to publish to Sonatype.
