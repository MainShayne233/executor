defmodule Executor.Runner.Ruby do

  def run(code) do
    file_name = create_file(code)
    System.cmd("ruby", [file_name])
    |> case do
      {result, 0} ->
        File.rm(file_name)
        {:ok, result}
      {_, 1} ->
        File.rm(file_name)
        {:error, "Error when executing code"}
    end
  end

  def create_file(code) do
    file_name = new_file_name()
    file_name
    |> File.write!( code |> sanitize_code |> code_template )
    file_name
  end

  def new_file_name, do: "./exe/ruby_run_#{:os.system_time}.rb"

  def sanitize_code(code) do
    code = code 
    |> String.replace(~s("), ~s(\\"))
    Regex.replace(~r/\#{(.*?)}/, code, "\#{\\1}")
    |> String.replace(~s(\#{), ~s(\\\#{))
  end

  def code_template(code) do
    """
    begin
      return_val = eval "\n#{code}\n"
      print "=> \#{return_val || 'nil'}"
    rescue Exception => e
      print e
    end
    """
  end

end
