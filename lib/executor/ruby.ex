defmodule Executor.Ruby do
  alias Executor.Shared

  @moduledoc """
  This module is responsible for executing ruby code.
  """

  def run(code), do: Shared.run("ruby", code)

  def new_file_name, do: "./exe/ruby_run_#{:os.system_time}.rb"

  def code_template(code) do
    """
    begin
      return_val = eval "\n#{code}\n"
      puts "#{Shared.std_out_terminated_indicator()}"
      print "#{Shared.return_indicator()}"
      print "\#{return_val || 'nil'}"
      print "#{Shared.return_indicator()}"
    rescue Exception => e
      print "#{Shared.error_type_indicator}"
      print "\#{e.class}"
      print "#{Shared.error_type_indicator}"
      print "#{Shared.error_message_indicator}"
      print "\#{e.message}"
      print "#{Shared.error_message_indicator}"
    end
    """
  end
end
