-- 날개길이 - 몸무게의 상관관계
-- 날개길이 : flipper_length_mm, 몸무게 : body_mass_g
SELECT
  species,
  ROUND(
    (AVG(flipper_length_mm*body_mass_g) - AVG(flipper_length_mm)*AVG(body_mass_g)) / 
    (STD(flipper_length_mm) * STD(body_mass_g)),
    3
  ) AS corr
FROM penguins
GROUP BY species