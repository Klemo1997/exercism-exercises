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
  def send_newsletter(emails_path, log_path, send_fun),
    do: with(
      log_file <- open_log(log_path),
      emails when is_list(emails) <- read_emails(emails_path),
      :ok <- Enum.each(emails, fn email ->  
        case send_fun.(email) do
            :ok -> log_sent_email(log_file, email)
            _ -> nil
        end
      end),
      :ok <- close_log(log_file),
      do: :ok
    )
end
