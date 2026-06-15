defmodule Newsletter do
  def read_emails(path) do
    {_, content} = File.read(path)

    trimmed_content = content
    |> String.trim_trailing("\n")

    if trimmed_content == "" do
      []
    else
      trimmed_content |> String.split("\n")
    end
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.binwrite(pid, email <> "\n")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    email_list = read_emails(emails_path)
    log_file = open_log(log_path)

    do_send_newsletter(email_list, log_file, send_fun)

    close_log(log_file)
  end

  defp do_send_newsletter([email | rest], log_file, send_fun) do
    res = send_fun.(email)

    if res == :ok do
      log_sent_email(log_file, email)
    end

    do_send_newsletter(rest, log_file, send_fun)
  end

  defp do_send_newsletter([], _, _) do
  end
end
