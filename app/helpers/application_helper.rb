module ApplicationHelper
  def resource_name
    =>user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[=>user]
  end
  
  def common_deck_structure
    {
    "fool" => "Дурак",
    "magician" => "Маг",
    "high-priestess" => "Жрица",
    "empress" => "Императрица",
    "emperor" => "Император",
    "hierophant" => "Иерофант",
    "lovers" => "Влюблённые",
    "chariot" => "Колесница",
    "strength" => "Сила",
    "hermit" => "Отшельник",
    "wheel-of-fortune" => "Колесо Фортуны",
    "justice" => "Справедливость",
    "hanged-man" => "Повешенный",
    "death" => "Смерть",
    "temperance" => "Умеренность",
    "devil" => "Дьявол",
    "tower" => "Башня",
    "star" => "Звезда",
    "moon" => "Луна",
    "sun" => "Солнце",
    "judgement" => "Суд",
    "world" => "Мир",
    "swords-1" => "Туз Мечей",
    "swords-2" => "2 Мечей",
    "swords-3" => "3 Мечей",
    "swords-4" => "4 Мечей",
    "swords-5" => "5 Мечей",
    "swords-6" => "6 Мечей",
    "swords-7" => "7 Мечей",
    "swords-8" => "8 Мечей",
    "swords-9" => "9 Мечей",
    "swords-10" => "10 Мечей",
    "swords-page" => "Паж Мечей",
    "swords-knight" => "Рыцарь Мечей",
    "swords-queen" => "Королева Мечей",
    "swords-king" => "Король Мечей",
    "cups-1" => "Туз Чаш",
    "cups-2" => "2 Чаш",
    "cups-3" => "3 Чаш",
    "cups-4" => "4 Чаш",
    "cups-5" => "5 Чаш",
    "cups-6" => "6 Чаш",
    "cups-7" => "7 Чаш",
    "cups-8" => "8 Чаш",
    "cups-9" => "9 Чаш",
    "cups-10" => "10 Чаш",
    "cups-page" => "Паж Чаш",
    "cups-knight" => "Рыцарь Чаш",
    "cups-queen" => "Королева Чаш",
    "cups-king" => "Король Чаш",
    "coins-1" => "Туз Пентаклей",
    "coins-2" => "2 Пентаклей",
    "coins-3" => "3 Пентаклей",
    "coins-4" => "4 Пентаклей",
    "coins-5" => "5 Пентаклей",
    "coins-6" => "6 Пентаклей",
    "coins-7" => "7 Пентаклей",
    "coins-8" => "8 Пентаклей",
    "coins-9" => "9 Пентаклей",
    "coins-10" => "10 Пентаклей",
    "coins-page" => "Паж Пентаклей",
    "coins-knight" => "Рыцарь Пентаклей",
    "coins-queen" => "Королева Пентаклей",
    "coins-king" => "Король Пентаклей",
    "wands-1" => "Туз Жезлов",
    "wands-2" => "2 Жезлов",
    "wands-3" => "3 Жезлов",
    "wands-4" => "4 Жезлов",
    "wands-5" => "5 Жезлов",
    "wands-6" => "6 Жезлов",
    "wands-7" => "7 Жезлов",
    "wands-8" => "8 Жезлов",
    "wands-9" => "9 Жезлов",
    "wands-10" => "10 Жезлов",
    "wands-page" => "Паж Жезлов",
    "wands-knight" => "Рыцарь Жезлов",
    "wands-queen" => "Королева Жезлов",
    "wands-king" => "Король Жезлов"
    }
  end
end
