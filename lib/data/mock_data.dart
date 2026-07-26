import '../models/heritage_place.dart';

class MockData {
  static final heritagePlaces = [
    HeritagePlace(
      id: '1',
      name: 'Adwa Victory Memorial Museum',
      country: 'Ethiopia',
      city: 'Addis Ababa',
      category: 'Museum',
      description:
          'The Adwa Victory Memorial Museum commemorates the Battle of Adwa (1896), where Ethiopian forces defeated Italian colonial troops, preserving Ethiopia\'s sovereignty and inspiring African independence movements worldwide.',
      imageUrl:
          'https://images.unsplash.com/photo-1572905421176-6fa2f11a236e?w=800&h=500&fit=crop',
      rating: 4.8,
      reviewCount: 342,
      openingHours: '9:00 AM - 5:00 PM (Mon-Sun)',
      ticketInfo: 'Adults: 200 ETB | Students: 100 ETB | Children: Free',
      contact: '+251 11 123 4567',
      latitude: 9.0192,
      longitude: 38.7525,
      isFeatured: true,
      photos: [
        'https://images.unsplash.com/photo-1572905421176-6fa2f11a236e?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1590846083693-f23fdede3a7e?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1580130775562-0ef92da028de?w=400&h=300&fit=crop',
      ],
      exhibits: [
        Exhibit(
          id: 'e1',
          name: 'Battle of Adwa Diorama',
          description:
              'A detailed miniature reconstruction of the Battle of Adwa, showing troop positions and the decisive moment of Ethiopian victory on March 1, 1896.',
          imageUrl:
              'https://images.unsplash.com/photo-1572905421176-6fa2f11a236e?w=400&h=300&fit=crop',
          category: 'Historical',
          qrCode: 'ADWA-DIORAMA-001',
          relatedExhibits: ['e2', 'e3'],
        ),
        Exhibit(
          id: 'e2',
          name: 'Emperor Menelik II Portrait Gallery',
          description:
              'Portraits and photographs of Emperor Menelik II and Empress Taytu Betul, who led the defense of Ethiopian sovereignty.',
          imageUrl:
              'https://images.unsplash.com/photo-1590846083693-f23fdede3a7e?w=400&h=300&fit=crop',
          category: 'Art',
          qrCode: 'ADWA-MENELIK-002',
          relatedExhibits: ['e1', 'e4'],
        ),
        Exhibit(
          id: 'e3',
          name: 'Weapons & Armor Collection',
          description:
              'Ethiopian spears, shields, and swords used at Adwa, displayed alongside captured Italian equipment.',
          imageUrl:
              'https://images.unsplash.com/photo-1580130775562-0ef92da028de?w=400&h=300&fit=crop',
          category: 'Artifacts',
          qrCode: 'ADWA-WEAPONS-003',
          relatedExhibits: ['e1', 'e5'],
        ),
        Exhibit(
          id: 'e4',
          name: 'Treaty of Wuchale Display',
          description:
              'Original and translated versions of the Treaty of Wuchale, whose disputed Article 17 sparked the conflict.',
          imageUrl:
              'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=300&fit=crop',
          category: 'Documents',
          qrCode: 'ADWA-TREATY-004',
        ),
        Exhibit(
          id: 'e5',
          name: 'Voices of Adwa — Oral History',
          description:
              'Audio recordings and transcripts of oral histories about Adwa passed down through generations.',
          imageUrl:
              'https://images.unsplash.com/photo-1478737270239-2f02b77fc618?w=400&h=300&fit=crop',
          category: 'Audio',
          audioUrl: 'audio/adwa_oral_history.mp3',
          qrCode: 'ADWA-ORAL-005',
        ),
      ],
      timeline: [
        TimelineEvent(
            year: '1889',
            title: 'Treaty of Wuchale',
            description:
                'Ethiopia and Italy sign the Treaty of Wuchale. Disputed interpretations of Article 17 lead to conflict.'),
        TimelineEvent(
            year: '1895',
            title: 'Italian Invasion Begins',
            description:
                'Italian forces advance from Eritrea in a campaign to colonize Ethiopia.'),
        TimelineEvent(
            year: 'Mar 1, 1896',
            title: 'Battle of Adwa',
            description:
                'Ethiopian forces under Emperor Menelik II defeat the Italian army in a decisive battle.'),
        TimelineEvent(
            year: '1896',
            title: 'Treaty of Addis Ababa',
            description:
                'Italy recognizes Ethiopia\'s full sovereignty, ending the First Italo-Ethiopian War.'),
        TimelineEvent(
            year: '1941',
            title: 'Liberation',
            description:
                'Ethiopia is liberated from Italian occupation with the return of Emperor Haile Selassie.'),
        TimelineEvent(
            year: '2024',
            title: 'Memorial Museum Opens',
            description:
                'The Adwa Victory Memorial Museum opens in Addis Ababa.'),
      ],
    ),
    HeritagePlace(
      id: '2',
      name: 'National Museum of Ethiopia',
      country: 'Ethiopia',
      city: 'Addis Ababa',
      category: 'Museum',
      description:
          'Home to Lucy (Dinkinesh) and one of Africa\'s richest archaeological collections — from prehistoric fossils to imperial crowns and Ethiopian Orthodox art.',
      imageUrl:
          'https://images.unsplash.com/photo-1566127444979-b20d8ce2484a?w=800&h=500&fit=crop',
      rating: 4.7,
      reviewCount: 2180,
      openingHours: '8:30 AM - 5:30 PM (Tue-Sun)',
      ticketInfo: 'Adults: 100 ETB | Students: 50 ETB | Foreigners: 200 ETB',
      contact: '+251 11 111 7150',
      latitude: 9.0384,
      longitude: 38.7612,
      isFeatured: true,
      exhibits: [
        Exhibit(
          id: 'n1',
          name: 'Lucy (Dinkinesh)',
          description:
              'The 3.2-million-year-old Australopithecus afarensis fossil discovered in Hadar in 1974 — one of the most important finds in human origins research.',
          imageUrl:
              'https://images.unsplash.com/photo-1566127444979-b20d8ce2484a?w=400&h=300&fit=crop',
          category: 'Paleontology',
          qrCode: 'NME-LUCY-001',
        ),
        Exhibit(
          id: 'n2',
          name: 'Imperial Crowns & Regalia',
          description:
              'Crowns, robes, and ceremonial objects from Ethiopian emperors, including pieces linked to Haile Selassie\'s court.',
          imageUrl:
              'https://images.unsplash.com/photo-1590846083693-f23fdede3a7e?w=400&h=300&fit=crop',
          category: 'Royal Collection',
          qrCode: 'NME-CROWNS-002',
        ),
        Exhibit(
          id: 'n3',
          name: 'Ethiopian Orthodox Icons',
          description:
              'Hand-painted icons and manuscript illuminations reflecting centuries of Ethiopian Christian tradition.',
          imageUrl:
              'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=300&fit=crop',
          category: 'Sacred Art',
          qrCode: 'NME-ICONS-003',
        ),
      ],
      timeline: [
        TimelineEvent(
            year: '1974',
            title: 'Lucy Discovered',
            description:
                'Donald Johanson\'s team finds Lucy (Dinkinesh) in the Afar region.'),
        TimelineEvent(
            year: 'Today',
            title: 'National Treasure',
            description:
                'The museum remains Ethiopia\'s primary home for paleontology and imperial heritage.'),
      ],
    ),
    HeritagePlace(
      id: '3',
      name: 'Rock-Hewn Churches of Lalibela',
      country: 'Ethiopia',
      city: 'Lalibela',
      category: 'Archaeological Site',
      description:
          'Eleven medieval monolithic churches carved from living rock in the 12th–13th centuries — a UNESCO World Heritage Site and living place of Orthodox pilgrimage.',
      imageUrl:
          'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=800&h=500&fit=crop',
      rating: 4.9,
      reviewCount: 5640,
      openingHours: '6:00 AM - 6:00 PM (Daily)',
      ticketInfo: 'Foreigners: 50 USD | Ethiopians: 100 ETB | Students: Discounted',
      contact: '+251 33 336 0047',
      latitude: 12.0310,
      longitude: 39.0476,
      isFeatured: true,
      exhibits: [
        Exhibit(
          id: 'lb1',
          name: 'Bete Giyorgis (St. George)',
          description:
              'The iconic cross-shaped church carved from a single rock — the masterpiece of Lalibela.',
          imageUrl:
              'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=400&h=300&fit=crop',
          category: 'Church',
          qrCode: 'LALIBELA-GIYORGIS-001',
        ),
        Exhibit(
          id: 'lb2',
          name: 'Bete Medhane Alem',
          description:
              'Said to be the world\'s largest monolithic church, dedicated to the Saviour of the World.',
          imageUrl:
              'https://images.unsplash.com/photo-1523805009345-7448845a9e53?w=400&h=300&fit=crop',
          category: 'Church',
          qrCode: 'LALIBELA-MEDHANE-002',
        ),
        Exhibit(
          id: 'lb3',
          name: 'Pilgrimage Tunnels',
          description:
              'A network of trenches and tunnels connecting the churches, still walked by pilgrims today.',
          imageUrl:
              'https://images.unsplash.com/photo-1489392191049-fc10c97e64b6?w=400&h=300&fit=crop',
          category: 'Architecture',
          qrCode: 'LALIBELA-TUNNELS-003',
        ),
      ],
      timeline: [
        TimelineEvent(
            year: 'c. 1181–1221',
            title: 'King Lalibela',
            description:
                'Zagwe King Gebre Meskel Lalibela commissions the rock churches as a "New Jerusalem".'),
        TimelineEvent(
            year: '1978',
            title: 'UNESCO Listing',
            description:
                'The Rock-Hewn Churches of Lalibela are inscribed as a World Heritage Site.'),
      ],
    ),
    HeritagePlace(
      id: '4',
      name: 'Axum Obelisks & Archaeological Site',
      country: 'Ethiopia',
      city: 'Axum',
      category: 'Archaeological Site',
      description:
          'Capital of the ancient Aksumite Empire — towering stelae, royal tombs, and the claimed resting place of the Ark of the Covenant at the Church of Our Lady Mary of Zion.',
      imageUrl:
          'https://images.unsplash.com/photo-1523805009345-7448845a9e53?w=800&h=500&fit=crop',
      rating: 4.8,
      reviewCount: 3120,
      openingHours: '8:00 AM - 5:30 PM (Daily)',
      ticketInfo: 'Adults: 200 ETB | Foreigners: 50 USD combined sites',
      contact: '+251 34 775 1234',
      latitude: 14.1324,
      longitude: 38.7168,
      isFeatured: true,
      exhibits: [
        Exhibit(
          id: 'ax1',
          name: 'Great Stele of Axum',
          description:
              'One of the world\'s tallest ancient monoliths — a granite marker of Aksumite royal power.',
          imageUrl:
              'https://images.unsplash.com/photo-1523805009345-7448845a9e53?w=400&h=300&fit=crop',
          category: 'Monument',
          qrCode: 'AXUM-STELE-001',
        ),
        Exhibit(
          id: 'ax2',
          name: 'King Ezana\'s Stele',
          description:
              'Inscribed stele linked to King Ezana, who adopted Christianity in the 4th century.',
          imageUrl:
              'https://images.unsplash.com/photo-1489392191049-fc10c97e64b6?w=400&h=300&fit=crop',
          category: 'Monument',
          qrCode: 'AXUM-EZANA-002',
        ),
        Exhibit(
          id: 'ax3',
          name: 'Church of Mary of Zion',
          description:
              'Ethiopia\'s most sacred church complex — tradition holds the Ark of the Covenant is kept here.',
          imageUrl:
              'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=400&h=300&fit=crop',
          category: 'Sacred Site',
          qrCode: 'AXUM-ZION-003',
        ),
      ],
      timeline: [
        TimelineEvent(
            year: '1st–7th c.',
            title: 'Aksumite Empire',
            description:
                'Axum thrives as a major Red Sea trading power linking Africa, Arabia, and the Mediterranean.'),
        TimelineEvent(
            year: 'c. 330',
            title: 'Christianization',
            description:
                'King Ezana converts to Christianity, making Ethiopia one of the world\'s earliest Christian states.'),
      ],
    ),
    HeritagePlace(
      id: '5',
      name: 'Fasil Ghebbi (Gondar Castles)',
      country: 'Ethiopia',
      city: 'Gondar',
      category: 'Historical Monument',
      description:
          'The royal enclosure of the Gondarine emperors — a UNESCO fortress-city of castles, churches, and baths that earned Gondar the name "Camelot of Africa".',
      imageUrl:
          'https://images.unsplash.com/photo-1516026672322-bc52d61a55d5?w=800&h=500&fit=crop',
      rating: 4.7,
      reviewCount: 2890,
      openingHours: '8:00 AM - 5:00 PM (Daily)',
      ticketInfo: 'Foreigners: 200 ETB | Ethiopians: 50 ETB',
      contact: '+251 58 111 0022',
      latitude: 12.6084,
      longitude: 37.4674,
      isFeatured: true,
      exhibits: [
        Exhibit(
          id: 'g1',
          name: 'Castle of Fasilides',
          description:
              'The main palace of Emperor Fasilides, founder of Gondar as Ethiopia\'s capital in the 17th century.',
          imageUrl:
              'https://images.unsplash.com/photo-1516026672322-bc52d61a55d5?w=400&h=300&fit=crop',
          category: 'Palace',
          qrCode: 'GONDAR-FASIL-001',
        ),
        Exhibit(
          id: 'g2',
          name: 'Fasilides Bath',
          description:
              'A pavilion and pool used for Timkat (Epiphany) celebrations — still filled with water for the festival each year.',
          imageUrl:
              'https://images.unsplash.com/photo-1489392191049-fc10c97e64b6?w=400&h=300&fit=crop',
          category: 'Monument',
          qrCode: 'GONDAR-BATH-002',
        ),
      ],
      timeline: [
        TimelineEvent(
            year: '1636',
            title: 'Capital Founded',
            description:
                'Emperor Fasilides establishes Gondar as the imperial capital.'),
        TimelineEvent(
            year: '1979',
            title: 'UNESCO Listing',
            description: 'Fasil Ghebbi is inscribed as a World Heritage Site.'),
      ],
    ),
    HeritagePlace(
      id: '6',
      name: 'Harar Jugol — Old Walled City',
      country: 'Ethiopia',
      city: 'Harar',
      category: 'Historical Monument',
      description:
          'A historic Islamic city of narrow alleys, 82 mosques, and colorful houses — once a major center of trade and Islamic learning in the Horn of Africa.',
      imageUrl:
          'https://images.unsplash.com/photo-1523805009345-7448845a9e53?w=800&h=500&fit=crop',
      rating: 4.6,
      reviewCount: 1540,
      openingHours: 'Open daily — gates close at night for some quarters',
      ticketInfo: 'City tour guide: from 300 ETB | Museum: 50–100 ETB',
      contact: '+251 25 666 1234',
      latitude: 9.3133,
      longitude: 42.1180,
      isFeatured: false,
      exhibits: [
        Exhibit(
          id: 'h1',
          name: 'Jugol City Walls',
          description:
              'The 16th-century walls and five historic gates that protect the old city of Harar.',
          imageUrl:
              'https://images.unsplash.com/photo-1523805009345-7448845a9e53?w=400&h=300&fit=crop',
          category: 'Architecture',
          qrCode: 'HARAR-WALLS-001',
        ),
        Exhibit(
          id: 'h2',
          name: 'Hyena Feeding Tradition',
          description:
              'A living cultural practice where local "hyena men" feed spotted hyenas outside the city walls at dusk.',
          imageUrl:
              'https://images.unsplash.com/photo-1516426122078-c23e76319801?w=400&h=300&fit=crop',
          category: 'Living Culture',
          qrCode: 'HARAR-HYENA-002',
        ),
      ],
      timeline: [
        TimelineEvent(
            year: '16th c.',
            title: 'Walls Built',
            description:
                'Harar\'s jugol walls are constructed, shaping the unique urban fabric still seen today.'),
        TimelineEvent(
            year: '2006',
            title: 'UNESCO Listing',
            description: 'Harar Jugol is inscribed as a World Heritage Site.'),
      ],
    ),
    HeritagePlace(
      id: '7',
      name: 'Simien Mountains National Park',
      country: 'Ethiopia',
      city: 'Debark',
      category: 'Natural Heritage',
      description:
          'Dramatic highland peaks, endemic wildlife including the gelada and Ethiopian wolf, and some of Africa\'s most spectacular trekking routes.',
      imageUrl:
          'https://images.unsplash.com/photo-1516026672322-bc52d61a55d5?w=800&h=500&fit=crop',
      rating: 4.9,
      reviewCount: 4210,
      openingHours: 'Park open year-round (best: Oct–Mar)',
      ticketInfo: 'Park fee: from 90 ETB/day | Scout & guide required',
      contact: '+251 58 111 8900',
      latitude: 13.2340,
      longitude: 38.0410,
      isFeatured: true,
    ),
    HeritagePlace(
      id: '8',
      name: 'Tiya Stelae Field',
      country: 'Ethiopia',
      city: 'Tiya',
      category: 'Archaeological Site',
      description:
          'A UNESCO field of carved standing stones south of Addis Ababa — enigmatic markers of a little-understood ancient culture of the Soddo region.',
      imageUrl:
          'https://images.unsplash.com/photo-1489392191049-fc10c97e64b6?w=800&h=500&fit=crop',
      rating: 4.5,
      reviewCount: 680,
      openingHours: '8:00 AM - 5:00 PM',
      ticketInfo: 'Adults: 50 ETB | Foreigners: 100 ETB',
      contact: '+251 11 000 0000',
      latitude: 8.4500,
      longitude: 38.6167,
      isFeatured: false,
      exhibits: [
        Exhibit(
          id: 't1',
          name: 'Carved Memorial Stelae',
          description:
              'Dozens of engraved stones featuring swords, human figures, and symbols — believed to mark ancient burial grounds.',
          imageUrl:
              'https://images.unsplash.com/photo-1489392191049-fc10c97e64b6?w=400&h=300&fit=crop',
          category: 'Monument',
          qrCode: 'TIYA-STELE-001',
        ),
      ],
    ),
  ];

  static final reviews = [
    MockReview(
      id: 'r1',
      userName: 'Hanna Bekele',
      userAvatar: 'HB',
      rating: 5.0,
      text:
          'The Adwa museum made me proud. The diorama and oral histories bring March 1, 1896 to life.',
      date: DateTime(2026, 7, 15),
      tip: 'Visit in the morning — cooler and quieter.',
    ),
    MockReview(
      id: 'r2',
      userName: 'Yonas Tadesse',
      userAvatar: 'YT',
      rating: 4.5,
      text:
          'Lalibela is unforgettable. Scanning Bete Giyorgis with HeritageOS and hearing the AI guide in Amharic was perfect.',
      date: DateTime(2026, 7, 10),
    ),
    MockReview(
      id: 'r3',
      userName: 'Sara Mohammed',
      userAvatar: 'SM',
      rating: 5.0,
      text:
          'Seeing Lucy at the National Museum and then reading the Axum timeline — Ethiopia\'s story is incredible.',
      date: DateTime(2026, 6, 28),
      tip: 'Combine National Museum + Adwa Memorial in one Addis day.',
    ),
  ];

  static final achievements = [
    Achievement(
      id: 'a1',
      title: 'First Steps',
      description: 'Visit your first Ethiopian heritage site',
      icon: '🏛️',
      isUnlocked: true,
    ),
    Achievement(
      id: 'a2',
      title: 'Highland Explorer',
      description: 'Visit 5 different sites across Ethiopia',
      icon: '🧭',
      isUnlocked: true,
    ),
    Achievement(
      id: 'a3',
      title: 'History Buff',
      description: 'Complete 10 Ethiopian heritage quizzes',
      icon: '📚',
      isUnlocked: false,
    ),
    Achievement(
      id: 'a4',
      title: 'Region Hopper',
      description: 'Visit sites in 3 different Ethiopian regions',
      icon: '🗺️',
      isUnlocked: false,
    ),
    Achievement(
      id: 'a5',
      title: 'QR Scanner',
      description: 'Scan 20 exhibit QR codes',
      icon: '📱',
      isUnlocked: true,
    ),
    Achievement(
      id: 'a6',
      title: 'AI Curious',
      description: 'Ask AI 50 questions about Ethiopian heritage',
      icon: '🤖',
      isUnlocked: false,
    ),
  ];
}
