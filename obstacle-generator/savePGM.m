function savePGM(filename, image)
    % Abre el archivo en modo de escritura
    fid = fopen(filename, 'wt');
    
    % Escribe el encabezado PGM
    fprintf(fid, 'P2\n');
    fprintf(fid, '%d %d\n', size(image, 2), size(image, 1));
    fprintf(fid, '%d\n', max(image(:)));
    
    % Escribe los datos de la imagen
    for row = 1:size(image, 1)
        fprintf(fid, '%d ', image(row, :));
        fprintf(fid, '\n');
    end
    
    % Cierra el archivo
    fclose(fid);
end
