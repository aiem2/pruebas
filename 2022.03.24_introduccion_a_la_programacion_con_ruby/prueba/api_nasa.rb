require "uri"
require "net/http"
require "JSON"

url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10"
key = "QrgGYffjwLsjVj0DAvj34OrM2af8fdgs2JbIWcdO"

def request(url,key)
    api_key = url+"&api_key="+key
    api_key_info = {url: url, key: key, api_key: api_key}
end

api_key = request(url,key)


def solicitud(idrequest)
    
    url = URI(idrequest)
    
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
  
    request = Net::HTTP::Get.new(url)
    request['app_id'] = '5de964f6-0bb3-48ce-a983-f08eff0456ad'
    response = https.request(request)
    JSON.parse(response.read_body)
    
end

fotos = solicitud(api_key[:api_key])


def build_web_page(fotos_nasa)
    ft_chemcam = {}
    ft_mahli = {}
    ft_navcam = {}
    cont_chemcam = 0
    cont_mahli = 0
    cont_navcam = 0
    n = fotos_nasa["photos"].count
    
    n.times do |i|
        if fotos_nasa["photos"][i]["camera"]["name"].to_s == "CHEMCAM"
             cont_chemcam += 1
             ft_chemcam[fotos_nasa["photos"][i]["id"]] = fotos_nasa["photos"][i]["img_src"]
             
            elsif fotos_nasa["photos"][i]["camera"]["name"].to_s == "MAHLI"
                cont_mahli += 1
                ft_mahli[fotos_nasa["photos"][i]["id"]] = fotos_nasa["photos"][i]["img_src"]
    
            else fotos_nasa["photos"][i]["camera"]["name"].to_s == "NAVCAM"
                cont_navcam += 1
                ft_navcam[fotos_nasa["photos"][i]["id"]] = fotos_nasa["photos"][i]["img_src"]           
        end  
    end

    fotos = "<!DOCTYPE html>\n<html lang='en'>\n<head>\n\t<meta charset=UTF-8>\n\t<meta http-equiv='X-UA-Compatible' content='IE=edge'>\n\t<meta name='viewport' content='width=device-width, initial-scale=1.0'>\n\t<title>Prueba Nasa</title>\n\t<meta name='author' content='Ignacio Espinosa'>\n</head>\n"
    fotos += "\n<body>\n\t<h1>Las fotos de Nasa</h1>\n\t<h2>En este caso analizaremos las fotos de tres cámaras: CHEMCAM, MAHLI y NAVCAM</h2>"
    
    fotos += "\n\t\t<ul>\n\t\t\t<li><h3>Cámara CHEMCAM</h3></li>\n\t\t\t<p>La cámara CHEMCAM tiene #{cont_chemcam} fotos</p>"
    fotos += "\n\t\t\t<ol>"
        ft_chemcam.each do |i,s|
            fotos += "\n\n\t\t\t<li style='font-weight:bolder'> Foto #{i}</li>\n\t\t\t<br>\n\t\t\t<img src='#{s}' alt='Foto #{i} de la Nasa' style='width:25vw'>'\n\t\t\t<br><br>"
        end
    fotos += "\n\t\t\t</ol>"


    fotos += "\n\t\t\t<li><h3>Cámara MAHLI</h3></li>\n\t\t\t<p>La cámara MAHLI tiene #{cont_mahli} fotos</p>"
    fotos += "\n\t\t\t<ol>"  
        ft_mahli.each do |i,s|
            fotos += "\n\n\t\t\t<li style='font-weight:bolder'> Foto #{i}</li>\n\t\t\t<br>\n\t\t\t<img src='#{s}' alt='Foto #{i} de la Nasa' style='width:25vw'>'\n\t\t\t<br><br>"
        end
        fotos += "\n\t\t\t</ol>"

    fotos += "\n\t\t\t<li><h3>Cámara NAVCAM</h3></li>\n\t\t\t<p>La cámara NAVCAM tiene #{cont_navcam} fotos</p>"
    fotos += "\n\t\t\t<ol>"
        ft_navcam.each do |i,s|
            fotos += "\n\n\t\t\t<li style='font-weight:bolder'> Foto #{i}</li>\n\t\t\t<br>\n\t\t\t<img src='#{s}' alt='Foto #{i} de la Nasa' style='width:25vw'>'\n\t\t\t<br><br>"
        end
        fotos += "\n\t\t\t</ol>"

    fotos += "\n\t\t</ul>\n</body>"

    File.write('fotos_nasa_web.html', fotos)
    
end

build_web_page(fotos)

def photos_count(fotos_nasa)
    fotos_camaras = {}
    cont_chemcam = 0
    cont_mahli = 0
    cont_navcam = 0
    n = fotos_nasa["photos"].count
    
    n.times do |i|
        if fotos_nasa["photos"][i]["camera"]["name"].to_s == "CHEMCAM"
             cont_chemcam += 1
                          
            elsif fotos_nasa["photos"][i]["camera"]["name"].to_s == "MAHLI"
                cont_mahli += 1
             
            else fotos_nasa["photos"][i]["camera"]["name"].to_s == "NAVCAM"
                cont_navcam += 1
        end  
    end

    fotos_camaras["CHEMCAM"] = cont_chemcam
    fotos_camaras["MAHLI"] = cont_mahli
    fotos_camaras["NAVCAM"] = cont_navcam

    puts "\n"
    puts fotos_camaras
end

print "Fotos por cámara"
photos_count(fotos)