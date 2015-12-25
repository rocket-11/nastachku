# encoding: utf-8

Configus.build Rails.env do
  #TODO расширить configus
  credentials_hash = YAML.load(File.read("config/credentials.yml"))

  env :production do
    now_time -> {Time.zone.now}

    pagination do
      admin_per_page 50
      audits_per_page 20
    end

    schedule do
      first_day do
        date Time.utc(2016, 4, 15)
        start_time DateTime.new(2016, 4, 15, 9, 0, 0, "MSK")
        finish_time DateTime.new(2016, 4, 15, 20, 30, 0, "MSK")
      end
      second_day do
        date Time.utc(2016, 4, 16)
        start_time DateTime.new(2016, 4, 16, 10, 0, 0, "MSK")
        finish_time DateTime.new(2016, 4, 16, 18, 45, 0, "MSK")
      end
    end

    mailer do
      default_host "nastachku.ru"
      default_from "noreply@nastachku.ru"
    end

    mail do
      info 'info@nastachku.ru'
    end

    badges do
      time_to_print_badges DateTime.new(2016, 4, 14, 18, 0, 0)
    end

    token do
      auth_lifetime 3.days
      old_user_welcome_lifetime 3.month
      remind_password_lifetime 1.hour
    end

    facebook do
      app_id credentials_hash["production"]["facebook"]["app_id"]
      app_secret credentials_hash["production"]["facebook"]["app_secret"]
    end

    twitter do
       key credentials_hash["production"]["twitter"]["key"]
       secret credentials_hash["production"]["twitter"]["secret"]
    end

    cs_cart do
      secret_key credentials_hash["production"]["cs-cart"]["secret_key"]
      enable_auth true
      shop_url "nastachku.cs-cart.ru"
    end

    platidoma do
      host 'pg.platidoma.ru'
      transaction_view_host 'https://cabinet.paygate.platidoma.ru'
    end

    payanyway do
      host 'https://payanyway.ru'
      transaction_view_host 'https://moneta.ru'
      test_mode 0
      payment_system_ids [
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

    timepad do
      maillist_add_items_url credentials_hash["production"]["timepad"]["maillist_add_items_url"]
      organization_id credentials_hash["production"]["timepad"]["organization_id"]
      maillist_id credentials_hash["production"]["timepad"]["maillist_id"]
      api_key credentials_hash["production"]["timepad"]["api_key"]
    end

    default_distributor 'nastachku.ru'

    phones do
      valeriy '+7(902)355-55-99'
    end
  end

  env :development, parent: :production do
    now_time -> {Time.zone.now + 16.hours}

    facebook do
      app_id credentials_hash["development"]["facebook"]["app_id"]
      app_secret credentials_hash["development"]["facebook"]["app_secret"]
    end

    cs_cart do
      enable_auth false
      secret_key credentials_hash["development"]["cs-cart"]["secret_key"]
      shop_url "10.10.10.10/shop"
    end

    platidoma do
      host 'pg-test.platidoma.ru'
    end

    payanyway do
      host 'https://demo.moneta.ru'
      test_mode 0
    end

    timepad do
      maillist_add_items_url credentials_hash["development"]["timepad"]["maillist_add_items_url"]
      organization_id credentials_hash["development"]["timepad"]["organization_id"]
      maillist_id credentials_hash["development"]["timepad"]["maillist_id"]
      api_key credentials_hash["development"]["timepad"]["api_key"]
    end

  end

  env :test, parent: :production do
    platidoma do
      host 'pg-test.platidoma.ru'
    end

    payanyway do
      host 'https://demo.moneta.ru'
      test_mode 0
    end
  end

  env :staging, parent: :production do
    now_time -> {Time.zone.now + 16.hours}

    mailer do
      default_host "stg.nastachku.ru"
      default_from "info@stg.nastachku.ru"
    end

    basic_auth do
      username credentials_hash["staging"]["basic_auth"]["username"]
      password credentials_hash["staging"]["basic_auth"]["password"]
    end

    facebook do
      app_id credentials_hash["staging"]["facebook"]["app_id"]
      app_secret credentials_hash["staging"]["facebook"]["app_secret"]
    end

    cs_cart do
      secret_key credentials_hash["staging"]["cs-cart"]["secret_key"]
      shop_url "shop-staging.nastachku.ru"
    end

    platidoma do
      host 'pg-test.platidoma.ru'
      transaction_view_host 'https://cabinet.paygate-test.platidoma.ru'
    end

    payanyway do
      host 'https://demo.moneta.ru'
      transaction_view_host 'https://demo.moneta.ru'
      test_mode 0
      payment_system_ids [
        1015,   # Монета.Ру
        1017,   # WebMoney
        31086, # QIWI Кошелёк
        # 32863, # Сбербанк
        31877, # Интернет-банк "Альфа-Клик"
        35850, # Интернет-банк "Промсвязьбанк"
        1025, # Интернет-банк "Faktura.ru"
        38592, # Интернет-банк "Русский Стандарт"
        32767, # VISA, Master Card
        1016, # Салоны связи "Связной"
      ]
    end

    timepad do
      maillist_add_items_url credentials_hash["staging"]["timepad"]["maillist_add_items_url"]
      organization_id credentials_hash["staging"]["timepad"]["organization_id"]
      maillist_id credentials_hash["staging"]["timepad"]["maillist_id"]
      api_key credentials_hash["staging"]["timepad"]["api_key"]
    end
  end
end
