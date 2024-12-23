import pytest
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

@pytest.fixture(scope="function", autouse=True) #Фикстура будет работать для каждого теста и ее не нужно будет прописывать постоянно. scope="function" будет открывать браузер для каждого теста отдельно
def driver(request):
    options = Options() #Данные опции позволяют запускаться браузеру внутри сред где нет интерфейса
    options.add_argument("--headless") 
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1920,1080")
    driver = webdriver.Chrome(options=options)
    request.cls.driver = driver
    yield driver
    driver.quit() #Закрывает браузер после прохождения теста
    