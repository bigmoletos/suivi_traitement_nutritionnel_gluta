from fpdf import FPDF
import datetime

def sanitize_text(text):
    """
    Nettoie le texte pour éviter les problèmes d'encodage dans le PDF
    """
    replacements = {
        "–": "-", "'": "'", "œ": "oe", "é": "e", "è": "e", "ê": "e",
        "à": "a", "ç": "c", "î": "i", "ï": "i", "ô": "o", "û": "u",
        "ù": "u", "â": "a", "ë": "e", "ü": "u", "ÿ": "y"
    }
    for old, new in replacements.items():
        text = text.replace(old, new)
    return text.encode('latin-1', 'replace').decode('latin-1')

# Création du PDF
pdf = FPDF()
pdf.set_auto_page_break(auto=True, margin=15)

# 1. Fiche de suivi
pdf.add_page()

# En-tête
pdf.set_font("Arial", "B", 16)
pdf.cell(0, 10, sanitize_text("Fiche de Suivi - Patient SA avec L-Glutamine"), ln=True, align="C")

# Date
pdf.set_font("Arial", "", 12)
pdf.cell(0, 10, sanitize_text(f"Date : {datetime.datetime.now().strftime('%d/%m/%Y')}"), ln=True)

# Informations patient
pdf.set_font("Arial", "B", 14)
pdf.cell(0, 10, sanitize_text("Informations du patient"), ln=True)
pdf.set_font("Arial", "", 12)
pdf.cell(0, 10, sanitize_text("Nom : _____________________________"), ln=True)
pdf.cell(0, 10, sanitize_text("Prénom : _____________________________"), ln=True)
pdf.cell(0, 10, sanitize_text("Date de naissance : _____________________________"), ln=True)

# Suivi quotidien
pdf.set_font("Arial", "B", 14)
pdf.cell(0, 10, sanitize_text("Suivi quotidien"), ln=True)
pdf.set_font("Arial", "", 12)

# Matin
pdf.set_font("Arial", "B", 12)
pdf.cell(0, 10, sanitize_text("Matin :"), ln=True)
pdf.set_font("Arial", "", 12)
pdf.cell(0, 10, sanitize_text("- Eau tiède + L-glutamine à jeun"), ln=True)
pdf.cell(0, 10, sanitize_text("- Thé vert ou tisane digestive (camomille, fenouil)"), ln=True)

# Déjeuner
pdf.set_font("Arial", "B", 12)
pdf.cell(0, 10, sanitize_text("Déjeuner :"), ln=True)
pdf.set_font("Arial", "", 12)
pdf.cell(0, 10, sanitize_text("- Quinoa aux légumes racines + pois chiches"), ln=True)
pdf.cell(0, 10, sanitize_text("- Filet de sardine ou maquereau (huile d'olive crue)"), ln=True)
pdf.cell(0, 10, sanitize_text("- Salade verte + huile de colza ou cameline"), ln=True)

# Collation
pdf.set_font("Arial", "B", 12)
pdf.cell(0, 10, sanitize_text("Collation :"), ln=True)
pdf.set_font("Arial", "", 12)
pdf.cell(0, 10, sanitize_text("- Compote sans sucre + graines de chia (si tolérées)"), ln=True)

# Dîner
pdf.set_font("Arial", "B", 12)
pdf.cell(0, 10, sanitize_text("Dîner :"), ln=True)
pdf.set_font("Arial", "", 12)
pdf.cell(0, 10, sanitize_text("- Soupe maison (courgette, patate douce, carottes)"), ln=True)
pdf.cell(0, 10, sanitize_text("- Riz complet ou millet + tofu ferme ou œuf poché"), ln=True)
pdf.cell(0, 10, sanitize_text("- Tisane calmante (mélisse, réglisse déglycyrrhizinée)"), ln=True)

# Observations
pdf.set_font("Arial", "B", 14)
pdf.cell(0, 10, sanitize_text("Observations"), ln=True)
pdf.set_font("Arial", "", 12)
pdf.cell(0, 10, sanitize_text("Date de début de la cure : _____________________________"), ln=True)
pdf.cell(0, 10, sanitize_text("Poids : _____________________   Tension artérielle : ____________________"), ln=True)
pdf.cell(0, 10, sanitize_text("État digestif (ballonnements, reflux, transit) : _____________________________"), ln=True)
pdf.cell(0, 10, sanitize_text("Douleurs articulaires (note sur 10) : _____________________________"), ln=True)
pdf.cell(0, 10, sanitize_text("Évolution ulcération genou : ____________________________________"), ln=True)
pdf.cell(0, 10, sanitize_text("Prise de L-glutamine (dose, heure) : _____________________________"), ln=True)
pdf.cell(0, 10, sanitize_text("Effets secondaires éventuels : _________________________________"), ln=True)
pdf.cell(0, 10, sanitize_text("Observations générales : _______________________________________"), ln=True)

# 2. Plan nutritionnel
pdf.add_page()
pdf.set_font("Arial", "B", 14)
pdf.cell(0, 10, sanitize_text("Plan Nutritionnel - Soutien Inflammatoire et Digestif"), ln=True, align="C")
pdf.ln(10)

pdf.set_font("Arial", "B", 12)
pdf.cell(0, 10, sanitize_text("Principes clés :"), ln=True)
pdf.set_font("Arial", "", 12)
pdf.multi_cell(0, 10, sanitize_text("""\
- Réduction des aliments pro-inflammatoires : gluten, produits laitiers, sucres raffinés, viandes transformées
- Apports renforcés en oméga-3 : poissons gras (sardine, maquereau), huile de colza/lin
- Aliments riches en glutamine naturelle : choux, betterave, persil, épinards
- Cuissons douces : vapeur, basse température
- Fractionnement des repas pour limiter les reflux
"""))

pdf.set_font("Arial", "B", 12)
pdf.cell(0, 10, sanitize_text("Exemple de journée type :"), ln=True)
pdf.set_font("Arial", "", 12)
pdf.multi_cell(0, 10, sanitize_text("""\
Petit-déjeuner :
- Compote sans sucre + flocons de sarrasin + graines de chia
- Thé vert ou tisane anti-reflux (camomille, guimauve)

Déjeuner :
- Poisson vapeur + riz complet + légumes verts vapeur
- Huile de lin (1 c. à soupe)
- Eau plate

Collation :
- Amandes trempées + infusion gingembre-curcuma

Dîner :
- Soupe de légumes + œuf poché
- Patate douce rôtie
- Yaourt de coco nature (si toléré)
"""))

# 3. Protocole personnalisé
pdf.add_page()
pdf.set_font("Arial", "B", 14)
pdf.cell(0, 10, sanitize_text("Protocole personnalisé - L-Glutamine et Spondylarthrite Ankylosante"), ln=True, align="C")

# Infos patient
pdf.ln(5)
pdf.set_font("Arial", "", 12)
pdf.multi_cell(0, 10, sanitize_text("""\
Profil patient :
- Homme, 50 ans, 1m70 pour 70 kg
- Sportif, aucun traitement en cours
- Atteint de spondylarthrite ankylosante
- Faiblesse rénale, tendance à l'hypertension
- Remontées acides et ulcération profonde du genou
"""))

# Protocole
pdf.set_font("Arial", "B", 12)
pdf.cell(0, 10, sanitize_text("1. Posologie L-Glutamine"), ln=True)

pdf.set_font("Arial", "", 12)
pdf.multi_cell(0, 10, sanitize_text("""\
Phase d'introduction :
- 2 g/jour pendant 5 jours, à jeun dans de l'eau tiède

Phase active :
- 5 g/jour (2,5 g matin + 2,5 g après-midi) pendant 4 à 6 semaines
- Éviter la prise avant le coucher

Phase d'entretien :
- 3 g/jour pendant 4 semaines, puis pause de 1 à 2 semaines

Forme recommandée : poudre pure sans additifs
"""))

# Adaptation reflux
pdf.set_font("Arial", "B", 12)
pdf.cell(0, 10, sanitize_text("2. Précautions en cas de remontées acides"), ln=True)

pdf.set_font("Arial", "", 12)
pdf.multi_cell(0, 10, sanitize_text("""\
- Prendre à distance des repas (2 h après)
- Éviter jus acides, vinaigre de cidre
- Option : DGL (réglisse déglycyrrhizinée), 400 mg avant les repas
"""))

# Co-suppléments
pdf.set_font("Arial", "B", 12)
pdf.cell(0, 10, sanitize_text("3. Co-suppléments recommandés"), ln=True)

pdf.set_font("Arial", "", 12)
pdf.multi_cell(0, 10, sanitize_text("""\
- Oméga-3 (EPA/DHA) : 2 g/jour
- Curcumine (phytosomale de type Meriva) : 500 mg x2/jour
- Vitamine D3 : 2000 à 4000 UI/j selon bilan
- Probiotiques : 10-20 milliards UFC/jour

Attention :
- Surveillance tensionnelle régulière (curcumine et DGL peuvent interagir)
- Prioriser formes sans sodium en cas d'hypertension
"""))

# Suivi
pdf.set_font("Arial", "B", 12)
pdf.cell(0, 10, sanitize_text("4. Suivi médical recommandé"), ln=True)

pdf.set_font("Arial", "", 12)
pdf.multi_cell(0, 10, sanitize_text("""\
- Bilan créatinine, urée, fonction hépatique toutes les 3-4 semaines
- Suivi tension artérielle et évolution de l'ulcération
- Suivi des remontées acides (évolution, intensité)
- Réévaluation à 6 semaines (CRP, test digestif, calprotectine si possible)
"""))

# Sauvegarde du PDF
pdf.output("suivi_quotidien.pdf")
