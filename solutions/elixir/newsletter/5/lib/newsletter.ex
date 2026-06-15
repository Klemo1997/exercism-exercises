defmodule Newsletter do
  @type io_device() :: pid()

  @spec read_emails(String.t()) :: list(String.t())
  def read_emails(path), do: File.read!(path) |> String.split()

  @spec open_log(String.t()) :: io_device()
  def open_log(path), do: File.open!(path, [:write])

  @spec log_sent_email(io_device(), String.t()) :: :ok
  def log_sent_email(pid, email), do: IO.puts(pid, email)

  @spec close_log(io_device()) :: :ok
  def close_log(pid), do: File.close(pid)

  @spec send_newsletter(String.t(), String.t(), (String.t() -> :ok | any())) :: :ok
  def send_newsletter(emails_path, log_path, send_fun) do
    log_file = open_log(log_path)
    
    read_emails(emails_path)
    |> Enum.each(fn email ->  
      if send_fun.(email) === :ok, do: log_sent_email(log_file, email)
    end)

    close_log(log_file)
  end
end
