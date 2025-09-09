

% --- Add (blob_size x blob_size) blob with amplitude blob_amp ---
blob_size = 4;
blob_amp = 20;
row_start = floor(N/2 - blob_size/2) + 1;
col_start = floor(N/2 - blob_size/2) + 1;
img(row_start:row_start+blob_size-1, col_start:col_start+blob_size-1) = ...
    img(row_start:row_start+blob_size-1, col_start:col_start+blob_size-1) + blob_amp;

subplot(2,4,1); imshow(uint8(img),[0 M-1 + blob_amp]);title('img');colormap('gray');colorbar;






% Video writer setup
v = VideoWriter('sensor_movie.avi');   % Create AVI file
v.FrameRate = 2;                       % Slow enough to see changes
open(v);

for frame = 1:4
  % Optionally, modify image per frame (demo: vary noise slightly)
    noisy_img = img + randn(size(img)) * frame * A_noise/2;
%   frame_to_write = uint8(255 * mat2gray(noisy_img));       % Normalize to [0,255]
    grayscale_frame_to_write = uint8(255 * mat2gray(img));   % Normalize to [0,255]
%    rgb_frame = ind2rgb(frame_to_write, jet(256));           % Convert to RGB for color
%   writeVideo(v, rgb_frame);
    writeVideo(v, grayscale_frame_to_write);
end

close(v); % Finalize and close video





