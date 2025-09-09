

% --- Add (blob_size x blob_size) blob with amplitude blob_amp ---
blob_size = 4;
blob_amp = 20;
row_start = floor(N/2 - blob_size/2) + 1;
col_start = floor(N/2 - blob_size/2) + 1;
img(row_start:row_start+blob_size-1, col_start:col_start+blob_size-1) = ...
    img(row_start:row_start+blob_size-1, col_start:col_start+blob_size-1) + blob_amp;

subplot(2,4,1); imshow(uint8(img),[0 M-1 + blob_amp]);title('img');colormap('gray');colorbar;

