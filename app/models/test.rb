class Test < ApplicationRecord
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  has_many :translations, through: :answers
  belongs_to :user
  
  accepts_nested_attributes_for :answers
  
  scope :for_user, lambda { |user|
      where("tests.user_id = ?", user.id)
  } 
  
  def maximum_score
    self.answers.size
  end
  
  def percentage_score
    (self.score.to_f / self.maximum_score.to_f*100).to_i
  end
  
  def feedback(mode=:neutre)
    mode = self.user.profanity.to_sym
    level = case self.percentage_score
      when (0..20)
        20
      when (21..50)
        50
      when (51..80)
        80
      when (81..99)
        90
      when (100)
        100
    end
    Test.feedback[level][mode].sample
  end
  
  def self.feedback
       {
    20 => {
      bisounours:[
        "Courage. Tu peux y arriver !",
        "Tu ne peux que progresser, ne perd pas espoir !",
        "Ce n'est pas grave, il n'y a pas que cela dans la vie."
      ],
      neutre:[
        "Ce n'est pas fameux.",
        "C'est l'un des scores les plus bas du classement.",
        "On ne vas pas se mentir, il y a encore du boulot."
      ],
      fais_moi_mal:[
        "Bravo! C'est l'un des pires résultats jamais atteints !",
        "Est-ce que tu traduis dans la bonne langue ?",
        "Tu n'es qu'une sombre merde.",
        "Nullissime. J'ai les yeux qui piquent."
      ]
    },
    50 => {
      bisounours:[
        "Il y a pire comme score.",
        "L'important, c'est le chemin. Continue et tu y arriveras !",
        "Tout n'est pas noir. Tu as plusieurs bonnes réponses.",
        "C'est vraiment une série difficile. Accroche-toi et tu y arriveras !"
      ],
      neutre:[
        "C'est un score insuffisant.",
        "Tu as besoin de meilleurs résultats pour réussir.",
        "Cette série nécessite encore du travail."
      ],
      fais_moi_mal:[
        "Ce n'est pas comme ça que tu vas pécho.",
        "Ma petite soeur de 3 ans a fait mieux.",
        "On se reverra en septembre.",
        "Un résultat pitoyable.",
        "Ouhouuu ? Y a quelqu'un ?"
      ]
    },
    80 => {
      bisounours:[
        "C'est vraiment pas mal!",
        "Ton résultat m'impressionne!",
        "Tu te débrouilles bien!"
      ],
      neutre:[
        "C'est un score honorable.",
        "C'est réussi, mais sans éclat.",
        "Tu n'as pas encore tout donné."
      ],
      fais_moi_mal:[
        "Ce n'est pas encore assez pour faire le malin.",
        "A chacune de tes erreurs, un bébé koala est décapité.",
        "Moyen de chez moyen.",
        "Achète-toi une guitare!"
      ]
    },
    90 => {
      bisounours:[
        "Waouw ! Voilà un score qui décoiffe.",
        "Je savais que tu pouvais le faire. Félicitations!",
        "Quel talent !"
      ],
      neutre:[
        "C'est un excellent score.",
        "Il t'en faudrait peu pour réussir un sans-fautes.",
        "Cette série nécessite encore du travail."
      ],
      fais_moi_mal:[
        "Haha ... tu te crois malin?",
        "Même pas capable de faire le maximum.",
        "Ici, c'est tout ou rien. Pour l'instant, c'est rien.",
        "Ca doit être la chance du débutant."
      ]
    },
    100 => {
      bisounours:[
        "Rien à dire. Continue comme ça !",
        "Trop bien, je suis trop content pour toi !",
        "Tu es la perfection même.",
        "C'est ton moment. Savoure-le !"
      ],
      neutre:[
        "C'est un score parfait.",
        "C'est un sans-fautes.",
        "Tu maîtrises cette série."
      ],
      fais_moi_mal:[
        "Tu es un pathétique no-life. Sors le nez de tes bouquins !",
        "Attention, on va te jeter des pierres à la sortie.",
        "Tu sais, tout cela est très surfait. En fait, ça ne sert à rien.",
        "Tu as peut-être réussi ce test, mais tu vas quand même rater ta vie."
      ]
    }
  }
  end
end
