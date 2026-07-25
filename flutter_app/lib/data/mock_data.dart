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
          'The Adwa Victory Memorial Museum commemorates the historic Battle of Adwa (1896), where Ethiopian forces decisively defeated Italian colonial troops, preserving Ethiopia\'s sovereignty and inspiring African independence movements worldwide.',
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
              'A detailed miniature reconstruction of the Battle of Adwa, showing troop positions and the decisive moment of Ethiopian victory.',
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
              'Original portraits and photographs of Emperor Menelik II and Empress Taytu Betul, the leaders who orchestrated the defense of Ethiopian sovereignty.',
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
              'Authentic Ethiopian weapons, shields, and armor used during the Battle of Adwa, alongside captured Italian equipment.',
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
              'The original and translated versions of the Treaty of Wuchale, whose disputed article led to the conflict.',
          imageUrl:
              'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400&h=300&fit=crop',
          category: 'Documents',
          qrCode: 'ADWA-TREATY-004',
        ),
        Exhibit(
          id: 'e5',
          name: 'Voices of Adwa - Oral History',
          description:
              'Audio recordings and transcripts of oral histories passed down through generations about the Battle of Adwa.',
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
                'Italian forces launch their campaign to colonize Ethiopia, advancing from Eritrea.'),
        TimelineEvent(
            year: 'Mar 1, 1896',
            title: 'Battle of Adwa',
            description:
                'Ethiopian forces under Emperor Menelik II defeat the Italian army in a decisive battle lasting several hours.'),
        TimelineEvent(
            year: '1896',
            title: 'Treaty of Addis Ababa',
            description:
                'Italy recognizes Ethiopia\'s full sovereignty, ending the First Italo-Ethiopian War.'),
        TimelineEvent(
            year: '1936',
            title: 'Italian Occupation',
            description:
                'Italy occupies Ethiopia during the Second Italo-Ethiopian War, but resistance continues.'),
        TimelineEvent(
            year: '1941',
            title: 'Liberation',
            description:
                'Ethiopian forces, with British support, liberate the country from Italian occupation.'),
        TimelineEvent(
            year: '2024',
            title: 'Memorial Museum Opens',
            description:
                'The Adwa Victory Memorial Museum opens, preserving the legacy of Ethiopian resistance for future generations.'),
        TimelineEvent(
            year: 'Today',
            title: 'Living Heritage',
            description:
                'The museum serves as a symbol of African independence and a source of national pride.'),
        TimelineEvent(
            year: 'Today',
            title: 'Living Heritage',
            description:
                'The museum serves as a symbol of African independence and a source of national pride.'),
        TimelineEvent(
            year: 'Today',
            title: 'Living Heritage',
            description:
                'The museum serves as a symbol of African independence and a source of national pride.'),
      ],
    ),
    HeritagePlace(
      id: '2',
      name: 'The Louvre',
      country: 'France',
      city: 'Paris',
      category: 'Museum',
      description:
          'The world\'s largest art museum and home to thousands of works including the Mona Lisa and Venus de Milo.',
      imageUrl:
          'https://images.unsplash.com/photo-1770713522187-d9c16e16a15b?w=800&h=500&fit=crop',
      rating: 4.9,
      reviewCount: 15420,
      openingHours: '9:00 AM - 6:00 PM (Closed Tuesdays)',
      ticketInfo: 'Adults: €22 | Under 18: Free | EU Residents: Free',
      contact: '+33 1 40 20 53 17',
      latitude: 48.8606,
      longitude: 2.3376,
      isFeatured: true,
      exhibits: [
        Exhibit(
          id: 'l1',
          name: 'Mona Lisa',
          description:
              'Leonardo da Vinci\'s masterpiece, painted between 1503-1519. The most famous portrait in the world.',
          imageUrl:
              'https://images.unsplash.com/photo-1770713522187-d9c16e16a15b?w=400&h=300&fit=crop',
          category: 'Painting',
          qrCode: 'LOUVRE-MONALISA-001',
        ),
        Exhibit(
          id: 'l2',
          name: 'Venus de Milo',
          description:
              'Ancient Greek sculpture created between 130-100 BC, one of the most famous works of ancient Greek sculpture.',
          imageUrl:
              'https://images.unsplash.com/photo-1772617616268-a2f27d194fce?w=400&h=300&fit=crop',
          category: 'Sculpture',
          qrCode: 'LOUVRE-VENUS-002',
        ),
        Exhibit(
          id: 'l3',
          name: 'Winged Victory of Samothrace',
          description:
              'Hellenistic sculpture of the Greek goddess Nike, dated to approximately 190 BC.',
          imageUrl:
              'https://images.unsplash.com/photo-1771456294161-7d09c625cf96?w=400&h=300&fit=crop',
          category: 'Sculpture',
          qrCode: 'LOUVRE-NIKE-003',
        ),
      ],
      timeline: [
        TimelineEvent(
            year: '1793',
            title: 'Museum Opens',
            description:
                'The Louvre opens as a public museum during the French Revolution.'),
        TimelineEvent(
            year: '1804',
            title: 'Napoleon\'s Expansion',
            description:
                'Napoleon significantly expands the museum\'s collection.'),
        TimelineEvent(
            year: '1989',
            title: 'Glass Pyramid',
            description:
                'I.M. Pei\'s glass pyramid entrance is completed.'),
        TimelineEvent(
            year: 'Today',
            title: 'World\'s Largest Museum',
            description:
                'Over 380,000 objects and 35,000 works on display.'),
      ],
    ),
    HeritagePlace(
      id: '3',
      name: 'British Museum',
      country: 'United Kingdom',
      city: 'London',
      category: 'Museum',
      description:
          'A public museum dedicated to human history, art, and culture, with a collection of some eight million works.',
      imageUrl:
          'https://images.unsplash.com/photo-1782466357373-515da25d313e?w=800&h=500&fit=crop',
      rating: 4.8,
      reviewCount: 12300,
      openingHours: '10:00 AM - 5:00 PM (Daily)',
      ticketInfo: 'Free admission | Special exhibitions may charge',
      contact: '+44 20 7323 8299',
      latitude: 51.5194,
      longitude: -0.1270,
      isFeatured: true,
      exhibits: [
        Exhibit(
          id: 'b1',
          name: 'Rosetta Stone',
          description:
              'Granodiorite stele inscribed with three versions of a decree issued in Memphis, Egypt in 196 BCE.',
          imageUrl:
              'https://images.unsplash.com/photo-1782466357373-515da25d313e?w=400&h=300&fit=crop',
          category: 'Artifact',
          qrCode: 'BRITISH-ROSETTA-001',
        ),
        Exhibit(
          id: 'b2',
          name: 'Egyptian Mummies',
          description:
              'The museum houses one of the finest collections of mummies and coffins outside of Egypt.',
          imageUrl:
              'https://images.unsplash.com/photo-1580130775562-0ef92da028de?w=400&h=300&fit=crop',
          category: 'Artifact',
          qrCode: 'BRITISH-MUMMIES-002',
        ),
      ],
      timeline: [
        TimelineEvent(
            year: '1753',
            title: 'Museum Founded',
            description:
                'Sir Hans Sloane donates his collection to the nation.'),
        TimelineEvent(
            year: '1759',
            title: 'Doors Open',
            description:
                'The British Museum opens to the public in Montagu House.'),
        TimelineEvent(
            year: 'Today',
            title: 'Global Collection',
            description:
                'Over 8 million objects spanning two million years of human history.'),
      ],
    ),
    HeritagePlace(
      id: '4',
      name: 'Acropolis of Athens',
      country: 'Greece',
      city: 'Athens',
      category: 'Archaeological Site',
      description:
          'An ancient citadel on a rocky outcrop above Athens, containing the remains of several ancient buildings including the Parthenon.',
      imageUrl:
          'https://images.unsplash.com/photo-1566927244565-9a96a147a998?w=800&h=500&fit=crop',
      rating: 4.9,
      reviewCount: 8900,
      openingHours: '8:00 AM - 8:00 PM (Summer) | 8:00 AM - 5:00 PM (Winter)',
      ticketInfo: 'Combined ticket: €30 | Valid for multiple sites',
      contact: '+30 21 0321 4172',
      latitude: 37.9715,
      longitude: 23.7267,
      isFeatured: true,
    ),
    HeritagePlace(
      id: '5',
      name: 'Yosemite National Park',
      country: 'United States',
      city: 'California',
      category: 'Natural Heritage',
      description:
          'A protected wilderness area in California\'s Sierra Nevada mountains, known for its granite cliffs, waterfalls, and giant sequoias.',
      imageUrl:
          'https://images.unsplash.com/photo-1491590324047-588cc8277f59?w=800&h=500&fit=crop',
      rating: 4.8,
      reviewCount: 22000,
      openingHours: 'Open 24 hours (Some areas seasonal)',
      ticketInfo: 'Per vehicle: \$35 | Individual: \$20',
      contact: '+1 209-372-0200',
      latitude: 37.8651,
      longitude: -119.5383,
    ),
    HeritagePlace(
      id: '6',
      name: 'Pompeii Ruins',
      country: 'Italy',
      city: 'Naples',
      category: 'Archaeological Site',
      description:
          'An ancient Roman city buried by volcanic ash from Mount Vesuvius in 79 AD, remarkably preserved for nearly 2,000 years.',
      imageUrl:
          'https://images.unsplash.com/photo-1572905421176-6fa2f11a236e?w=800&h=500&fit=crop',
      rating: 4.7,
      reviewCount: 9800,
      openingHours: '9:00 AM - 7:00 PM (Summer) | 9:00 AM - 5:00 PM (Winter)',
      ticketInfo: 'Adults: €18 | EU 18-25: €2 | Under 18: Free',
      contact: '+39 081 857 5329',
      latitude: 40.7484,
      longitude: 14.4848,
    ),
    HeritagePlace(
      id: '7',
      name: 'Great Wall of China',
      country: 'China',
      city: 'Beijing',
      category: 'Historical Monument',
      description:
          'A series of fortifications made of stone, brick, and other materials, stretching over 13,000 miles across northern China.',
      imageUrl:
          'https://images.unsplash.com/photo-1508804185872-d7badad00f7d?w=800&h=500&fit=crop',
      rating: 4.8,
      reviewCount: 31000,
      openingHours: '7:30 AM - 5:30 PM (Varies by section)',
      ticketInfo: 'Badaling: ¥40 (Apr-Oct) | ¥35 (Nov-Mar)',
      contact: '+86 10 6912 1422',
      latitude: 40.4319,
      longitude: 116.5704,
    ),
    HeritagePlace(
      id: '8',
      name: 'Taj Mahal',
      country: 'India',
      city: 'Agra',
      category: 'Historical Monument',
      description:
          'An ivory-white marble mausoleum built by Mughal Emperor Shah Jahan in memory of his wife Mumtaz Mahal.',
      imageUrl:
          'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=800&h=500&fit=crop',
      rating: 4.9,
      reviewCount: 28000,
      openingHours: '30 min before sunrise - 30 min before sunset (Closed Fridays)',
      ticketInfo: 'Indians: ₹50 | Foreigners: ₹1100',
      contact: '+91 562 222 7261',
      latitude: 27.1751,
      longitude: 78.0421,
    ),
  ];

  static final reviews = [
    Review(
      id: 'r1',
      userName: 'Sarah Chen',
      userAvatar: 'SC',
      rating: 5.0,
      text:
          'Absolutely incredible! The Adwa Victory Memorial Museum is a powerful tribute to Ethiopian resistance. The diorama of the battle is breathtaking.',
      date: DateTime(2026, 7, 15),
      tip: 'Visit in the morning for fewer crowds.',
    ),
    Review(
      id: 'r2',
      userName: 'Michael Brooks',
      userAvatar: 'MB',
      rating: 4.5,
      text:
          'Very informative and well-curated. The AI guide feature made the experience even more engaging. Highly recommend!',
      date: DateTime(2026, 7, 10),
    ),
    Review(
      id: 'r3',
      userName: 'Fatima Al-Rashid',
      userAvatar: 'FA',
      rating: 5.0,
      text:
          'A must-visit for anyone interested in African history. The museum beautifully captures the spirit of Ethiopian independence.',
      date: DateTime(2026, 6, 28),
      tip: 'Allow at least 2-3 hours for a thorough visit.',
    ),
  ];

  static final achievements = [
    Achievement(
      id: 'a1',
      title: 'First Steps',
      description: 'Visit your first heritage site',
      icon: '🏛️',
      isUnlocked: true,
    ),
    Achievement(
      id: 'a2',
      title: 'Explorer',
      description: 'Visit 5 different heritage sites',
      icon: '🧭',
      isUnlocked: true,
    ),
    Achievement(
      id: 'a3',
      title: 'History Buff',
      description: 'Complete 10 quizzes',
      icon: '📚',
      isUnlocked: false,
    ),
    Achievement(
      id: 'a4',
      title: 'Globe Trotter',
      description: 'Visit heritage sites in 3 different countries',
      icon: '🌍',
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
      description: 'Ask AI 50 questions about exhibits',
      icon: '🤖',
      isUnlocked: false,
    ),
  ];
}
