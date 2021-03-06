namespace :db do
  desc 'Clean data except users'
  task :clean_except_users => :environment do
    models_to_destroy = [
      AfterpartyTicket, Lecture::Feedback, Ticket, Order, TicketCode,
      Campaign, Discount, EventUser, Event, Lecture, MailParams,
      News, Coupon, Report, Slot, Distributor, Topic, UserTopic,
      UsersList, User::PromoCode, Voting, Auditable::Audit
    ]

    models_to_destroy.each(&:destroy_all)

    User.update_all({
                      show_as_participant: false,
                      invisible_lector: false,
                      not_going_to_conference: false,
                      pay_state: :not_paid_part,
                      reason_to_give_ticket: nil,
                      code_activation_count: 0,
                      last_code_activation_at: nil,
                      in_carousel: false,
                      timepad_state: :unsynchronized
                    })
  end
end
