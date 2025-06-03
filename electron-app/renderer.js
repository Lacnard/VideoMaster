const { exec } = require('child_process');

document.getElementById('run').addEventListener('click', () => {
  const op = document.getElementById('operation').value;
  const url = document.getElementById('url').value;
  const input = document.getElementById('input').value;
  const output = document.getElementById('output').value;
  const start = document.getElementById('start').value;
  const end = document.getElementById('end').value;
  let cmd = '';

  switch(op) {
    case 'download-video':
      cmd = `yt-dlp -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best "${url}"`;
      break;
    case 'download-audio':
      cmd = `yt-dlp -x --audio-format mp3 "${url}"`;
      break;
    case 'convert-mp3':
      cmd = `ffmpeg -i "${input}" -vn -acodec mp3 "${output}.mp3"`;
      break;
    case 'cut-video':
      cmd = `ffmpeg -i "${input}" -ss ${start} -to ${end} -c copy "${output}"`;
      break;
  }

  const log = document.getElementById('log');
  log.textContent = `Running: ${cmd}\n`;

  const child = exec(cmd);
  child.stdout.on('data', data => log.textContent += data);
  child.stderr.on('data', data => log.textContent += data);
  child.on('exit', code => log.textContent += `\nProcess exited with code ${code}`);
});
