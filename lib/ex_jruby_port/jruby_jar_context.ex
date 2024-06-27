defmodule ExJrubyPort.JrubyJarContext do
  alias ExJrubyPort.JrubyJarContext
  use TypedStruct

  typedstruct do
    field(:java_path, any(), default: System.find_executable("java"))

    field(:jruby_jar_path, any(),
      default: Path.expand(Path.join([__DIR__, "..", "..", "jars", "jruby-complete-9.4.7.0.jar"]))
    )
  end

  def set_java_path(ctx, path), do: %JrubyJarContext{ctx | java_path: path}
  def set_jruby_jar_path(ctx, path), do: %JrubyJarContext{ctx | jruby_jar_path: path}
end
