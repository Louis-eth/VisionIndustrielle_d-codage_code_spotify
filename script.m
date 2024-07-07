clear all;
close all;
pkg load image;

figure(1);
img = imread("chanson1.jpg");
subplot(2, 2, 1);
imshow(img);
title("code barre 2of5 n°1");

image_ndg = rgb2gray(img);
subplot(2, 2, 2);
imshow(image_ndg);
title("ndg");

seuil = 200;
binary = 255 * (image_ndg > seuil);
subplot(2, 2, 3);
imshow(binary);
title("seuil");

label_image = bwlabel(binary);
num_objects = max(label_image(:));

subplot(2, 2, 4);
imshow(label2rgb(label_image));
title("Objets etiquetes");

disp(['Nombre d objets indentifier : ', num2str(num_objects)]);

props = regionprops(label_image, 'Area');

disp('Taille des labels:');
for i = 1:num_objects
    disp(['Taille objet ', num2str(i), ': ', num2str(props(i).Area)]);
end

intervalle = (props(2).Area + props(13).Area) / 8;

seuilCode = [props(2).Area, props(2).Area + (1:7) * intervalle, 5000];

data = NaN(1, num_objects - 1);

for i = 2:num_objects
    idx = find(seuilCode(1:end-1) <= props(i).Area & props(i).Area <= seuilCode(2:end));
    if ~isempty(idx)
        data(i-1) = idx;
    end
end
data = transpose(data);
disp(data);
