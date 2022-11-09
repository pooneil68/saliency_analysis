clearvars;

image_list ={
    'image01.jpg'
    'image02.jpg'
    'image03.jpg'
    'image04.jpg'
    'image05.jpg'
    'image06.jpg'
    'image07.jpg'
    'image08.jpg'
    'image09.jpg'
    'image10.jpg'
    'image11.jpg'
    'image12.jpg'
    'image13.jpg'
    'image14.jpg'
    'image15.jpg'
    'image16.jpg'
    'image17.jpg'
    'image18.jpg'
    'image19.jpg'
    'image20.jpg'
    'image21.jpg'
    'image22.jpg'
    'image23.jpg'
    'image24.jpg'
    'image25.jpg'
    'image26.jpg'
    'image27.jpg'
    'image28.jpg'
    'image29.jpg'
    'image30.jpg'
    'image31.jpg'
    'image32.jpg'
    'image33.jpg'
    'image34.jpg'
    'image35.jpg'
    'image36.jpg'
    'image37.jpg'
    'image38.jpg'
    'image39.jpg'
    'image40.jpg'
    'image41.jpg'
    'image42.jpg'
    'image43.jpg'
    'image44.jpg'
    'image45.jpg'
    'image46.jpg'
    'image47.jpg'
    'image48.jpg'
    'image49.jpg'
    'image50.jpg'
    'image51.jpg'
    'image52.jpg'
    'image53.jpg'
    'image54.jpg'
    'image55.jpg'
    'image56.jpg'
    };

saliency_data = [];
for ii = 1:length(image_list)
    image_name = image_list{ii};
    image_stem = image_name(1:end-4);
    saliency_data{ii}.image_stem = image_stem;
    img0 = imread(['images/' image_name]);
    saliency_data{ii}.image = img0;
end
save('saliency_data0901.mat', 'saliency_data')
