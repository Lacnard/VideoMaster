const { exec } = require('child_process');


const tabs = document.querySelectorAll('.tabs li');
const tabViews = document.querySelectorAll('.tab');

// switch tabs
tabs.forEach(tab => {
  tab.addEventListener('click', () => {
    document.querySelector('.tabs li.active').classList.remove('active');
    tab.classList.add('active');
    tabViews.forEach(view => view.classList.add('hidden'));
    document.getElementById(tab.dataset.tab).classList.remove('hidden');
  });
});

const toolOp = document.getElementById('tool-op');
const timeRange = document.getElementById('time-range');
function toggleTimeRange() {
  if (toolOp.value === 'cut-video') {
    timeRange.classList.remove('hidden');
  } else {
    timeRange.classList.add('hidden');
  }
}
toolOp.addEventListener('change', toggleTimeRange);
toggleTimeRange();

function runCommand(cmd) {
  const log = document.getElementById('log');
  log.textContent = `Running: ${cmd}\n`;
  const child = exec(cmd);
  child.stdout.on('data', data => log.textContent += data);
  child.stderr.on('data', data => log.textContent += data);
  child.on('exit', code => log.textContent += `\nExited with code ${code}`);
}

document.getElementById('run').addEventListener('click', () => {
  const activeTab = document.querySelector('.tabs li.active').dataset.tab;
  let cmd = '';

  if (activeTab === 'download') {
    const url = document.getElementById('url').value;
    const op = document.getElementById('download-op').value;
    if (op === 'download-video') {
      cmd = `yt-dlp -f bestvideo+bestaudio "${url}"`;
    } else {
      cmd = `yt-dlp -x --audio-format mp3 "${url}"`;
    }
  } else if (activeTab === 'tools') {
    const input = document.getElementById('input').value;
    const output = document.getElementById('output').value;
    const op = toolOp.value;
    switch (op) {
      case 'convert-mp3':
        cmd = `ffmpeg -i "${input}" -vn -acodec mp3 "${output}.mp3"`;
        break;
      case 'cut-video':
        const start = document.getElementById('start').value;
        const end = document.getElementById('end').value;
        cmd = `ffmpeg -i "${input}" -ss ${start} -to ${end} -c copy "${output}"`;
        break;
      case 'compress':
        cmd = `ffmpeg -i "${input}" -vcodec libx264 -crf 28 "${output}"`;
        break;
      case 'extract-audio':
        cmd = `ffmpeg -i "${input}" -q:a 0 -map a "${output}.mp3"`;
        break;
    }
  }

  if (cmd) {
    runCommand(cmd);
  }

});
