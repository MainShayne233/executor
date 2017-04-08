defmodule Executor.Ruby do
  alias Executor.Shared

  @moduledoc """
  This module is responsible for executing ruby code.
  The response should be identical to that of irb, where
  print/put statements are returned, and the actual return value
  is preceaded by '=>'
  """

  def run(code), do: Shared.run("ruby", code)

  def new_file_name, do: "./exe/ruby_run_#{:os.system_time}.rb"

  def code_template(code) do
    """
    begin
      return_val = eval "\n#{code}\n"
      print "=> \#{return_val || 'nil'}"
    rescue Exception => e
      print e.class
      print ': '
      print e.message
    end
    """
  end
end
