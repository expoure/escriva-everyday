from bs4 import BeautifulSoup 
import requests
import sqlite3

con = sqlite3.connect("escriva.db")
cur = con.cursor()

cur.execute("""CREATE TABLE IF NOT EXISTS quotes (
                    id integer PRIMARY KEY AUTOINCREMENT,
                    book_name text,
                    chapter_name text,
                    quote_number texy,
                    quote text,
                    bookmarked integer default 0,
                    read_at DATE
                );""")

cur.execute("""CREATE TABLE IF NOT EXISTS settings (
                    id integer PRIMARY KEY AUTOINCREMENT,
                    notifications TIME DEFAULT (time('07:00:00')),
                    caminho integer default 1,
                    sulco integer default 1,
                    forja integer default 1
                );""")
cur.execute("INSERT INTO settings (caminho, sulco, forja) VALUES ('1','1','1')")

for ponto in range(1, 1000):
    caminhoUrl = "https://www.escrivaworks.org.br/book/caminho-ponto-" + str(ponto) + ".htm"
    sulcoUrl = "https://www.escrivaworks.org.br/book/sulco-ponto-" + str(ponto) + ".htm"
    forjaUrl = "https://www.escrivaworks.org.br/book/forja-ponto-" + str(ponto) + ".htm"
    caminhoResponse = requests.get(caminhoUrl)
    sulcoResponse = requests.get(sulcoUrl)
    forjaResponse = requests.get(forjaUrl)

    caminhoSoup = BeautifulSoup(caminhoResponse.text, "html.parser")
    sulcoSoup = BeautifulSoup(sulcoResponse.text, "html.parser")
    forjaSoup = BeautifulSoup(forjaResponse.text, "html.parser")

    caminhoFrase = caminhoSoup.find("p").getText()
    caminhoPonto = caminhoSoup.find_all("a", {"class": "pathdest"})[1].getText()
    caminhoCap = caminhoSoup.find_all("a", {"class": "path"})[0].getText().strip()

    cur.execute(
        "INSERT INTO quotes (book_name, chapter_name, quote_number, quote) VALUES (?, ?, ?, ?)",
        ('Caminho', caminhoCap, caminhoPonto, caminhoFrase)
    )

    sulcoFrase = sulcoSoup.find("p").getText()
    sulcoPonto = sulcoSoup.find_all("a", {"class": "pathdest"})[1].getText()
    sulcoCap = sulcoSoup.find_all("a", {"class": "path"})[0].getText().strip()

    cur.execute(
        "INSERT INTO quotes (book_name, chapter_name, quote_number, quote) VALUES (?, ?, ?, ?)",
        ('Sulco', sulcoCap, sulcoPonto, sulcoFrase)
    )

    forjaFrase = forjaSoup.find("p").getText()
    forjaPonto = forjaSoup.find_all("a", {"class": "pathdest"})[1].getText()
    forjaCap = forjaSoup.find_all("a", {"class": "path"})[0].getText().strip()

    cur.execute(
        "INSERT INTO quotes (book_name, chapter_name, quote_number, quote) VALUES (?, ?, ?, ?)",
        ('Forja', forjaCap, forjaPonto, forjaFrase)
    )

    print('Terminando para os pontos número {}'.format(ponto))

con.commit()
con.close()