function dom_generator(r,i,epsilon)
    % Prellocate memory for the figure
    f1 = figure('Visible', 'off'); 

    % Fixed axis limits 
    xlim([0, 1]);
    ylim([0, 1]);

    for idx = 1:i
        points = rand(r,2);
        x = points(:, 1);
        y = points(:, 2);

        % Order points clockwise
        cx = mean(x);
        cy = mean(y);
        a = atan2(y - cy, x - cx); % Angles
        [~, order] = sort(a); 
        x = x(order);
        y = y(order);

        polygonal_path = polyshape(x,y); % Create polygon

        % Ensure the area is greather than epsilon
        while area(polygonal_path) < epsilon
            points = rand(r,2);
            x = points(:,1);
            y = points(:,2);

            cx = mean(x);
            cy = mean(y);
            a = atan2(y - cy, x - cx);
            [~, order] = sort(a);
            x = x(order);
            y = y(order);

            polygonal_path = polyshape(x,y);
            end
    % Plot the obstacle in black and white
    plot(polygonal_path, 'FaceColor', 'k', 'FaceAlpha', 1); 
    xlim([0, 1]);
    ylim([0, 1]);

    axis off;    % Oculta los ejes
    

    % Get the current frame as an image
    F = getframe(gca);
    I = rgb2gray(F.cdata);

    % Convert image to desired range 
    I = uint8(255*mat2gray(I));

    % Save as PGM 
    text = "new obstacles/obs_"+idx+".pgm";
    savePGM(text,I);

    % Clear axes for the next plot
    cla;
    if mod(idx, 10) == 0
        s = sprintf('--- Creación de obstáculo %d -----',idx);
        disp(s)
    end
    end

    close(f1);
end

   