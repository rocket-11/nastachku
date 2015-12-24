PaymentSystems::Payanyway.configure do |config|
  config.host = configus.payanyway.host
  config.payment_url = URI.join config.host, '/assistant.htm'
  config.id = Rails.application.secrets.payanyway_id
  config.integrity_check_code = Rails.application.secrets.payanyway_integrity_check_code
  config.currency = 'RUB'
  config.test_mode = configus.payanyway.test_mode
  config.payment_system_ids = [
    1015,   # Монета.Ру
    1017,   # WebMoney
    822360, # QIWI Кошелёк
    # 510801, # Сбербанк
    587412, # Интернет-банк "Альфа-Клик"
    661709, # Интернет-банк "Промсвязьбанк"
    609111, # Интернет-банк "Faktura.ru"
    786203, # Интернет-банк ОАО "УБРиР"
    845902, # Интернет-банк "Русский Стандарт"
    843858, # VISA, Master Card
    248362, # Салоны связи "Связной"
    913604  # Салоны связи "Евросеть"
  ]
end
